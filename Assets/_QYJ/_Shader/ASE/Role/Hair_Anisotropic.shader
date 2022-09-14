// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hair_Anisotropic"
{
	Properties
	{
		[HDR]_Color("基础色", Color) = (0.9779412,0.7868161,0.6831207,0.997)
		_Brightness("亮度", Range( 0 , 3)) = 1
		_BaseMap("基础图", 2D) = "white" {}
		_BumpMap("法线图", 2D) = "bump" {}
		_BumpScale("法线强度", Range( -2 , 2)) = 1
		_MaskMap("遮罩图（RG各向异性 BAO）", 2D) = "white" {}
		[Toggle]_AO("AO", Float) = 1
		_AnisotropyOffset("各向异性偏移", Float) = -1.5
		_AnisotropySpecRang("各向异性高光范围", Range( 0.01 , 1)) = 0.01
		_Anisotropy1SpecColor("各向异性1高光颜色", Color) = (0.9632353,0.9038391,0.8499135,0)
		[HDR]_Anisotropy2SpecColor1("各向异性2高光颜色", Color) = (0.9632353,0.9038391,0.8499135,0)
		_Anisotropy1Rang("各向异性1范围", Range( 0 , 10)) = 3.5
		_Anisotropy2Rang("各向异性2范围", Range( 1 , 20)) = 7.5
		_Metallic("金属度", Range( 0 , 1)) = 0.3
		_Smoothness("平滑度", Range( 0 , 1)) = 0.3
		_Cutoff("Cutoff", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		uniform float _Cutoff;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _BumpScale;
		uniform float4 _Anisotropy1SpecColor;
		uniform sampler2D _MaskMap;
		uniform float4 _MaskMap_ST;
		uniform float _AnisotropyOffset;
		uniform float _Anisotropy1Rang;
		uniform float _Anisotropy2Rang;
		uniform float4 _Anisotropy2SpecColor1;
		uniform float _AO;
		uniform float _AnisotropySpecRang;
		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform float4 _Color;
		uniform float _Brightness;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float2 uv_MaskMap = i.uv_texcoord * _MaskMap_ST.xy + _MaskMap_ST.zw;
			float4 tex2DNode65 = tex2D( _MaskMap, uv_MaskMap );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult156 = dot( ( ase_worldBitangent + ( ase_normWorldNormal * ( tex2DNode65.r + ( tex2DNode65.g * _AnisotropyOffset ) ) ) ) , ase_worldViewDir );
			float _AnisotropyVar263 = saturate( ( 1.0 - ( dotResult156 * dotResult156 ) ) );
			float dotResult117 = dot( ase_worldViewDir , ase_worldNormal );
			float lerpResult276 = lerp( 1.0 , 11.0 , _AnisotropySpecRang);
			float _SpecRangeVar261 = pow( saturate( dotResult117 ) , lerpResult276 );
			float4 _AnisotropySpecVar274 = ( ( ( _Anisotropy1SpecColor * pow( _AnisotropyVar263 , exp2( _Anisotropy1Rang ) ) ) + ( pow( _AnisotropyVar263 , exp2( _Anisotropy2Rang ) ) * _Anisotropy2SpecColor1 ) ) * (( _AO )?( tex2D( _MaskMap, uv_MaskMap ).b ):( 1.0 )) * _SpecRangeVar261 );
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			float4 tex2DNode257 = tex2D( _BaseMap, uv_BaseMap );
			o.Albedo = ( _AnisotropySpecVar274 + ( tex2DNode257 * _Color * _Brightness ) ).rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
			clip( tex2DNode257.a - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d9 d3d11_9x d3d11 glcore gles gles3 metal 
		#pragma surface surf Standard keepalpha fullforwardshadows nofog nometa noforwardadd 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
268;596;1531;733;-1845.493;483.484;1.831941;True;True
Node;AmplifyShaderEditor.CommentaryNode;142;-1794.297,-319.6868;Inherit;False;1674.286;508.7974;;14;263;271;159;148;156;155;140;138;139;79;137;235;77;65;各向异性;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-1652.375,102.8873;Float;False;Property;_AnisotropyOffset;各向异性偏移;7;0;Create;False;0;0;0;False;0;False;-1.5;-1.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;65;-1780.61,-85.05431;Inherit;True;Property;_MaskMap;遮罩图（RG各向异性 BAO）;5;0;Create;False;0;0;0;False;0;False;-1;None;607a1288072a01b4c8974b65383f253c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;235;-1466.142,30.63606;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;137;-1381.639,-199.0114;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;79;-1320.962,-55.14521;Inherit;False;2;2;0;FLOAT;0.8;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;138;-1154.709,-128.5013;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexBinormalNode;139;-1204.79,-279.6035;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;155;-1037.239,-43.03154;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-997.0635,-215.1973;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;156;-831.6837,-157.9501;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-710.9123,-170.2248;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;166;645.0734,486.606;Inherit;False;822.4626;405.0605;;8;119;276;261;118;273;117;115;116;高光范围;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;159;-591.0815,-170.6231;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;144;-68.35479,-498.5406;Inherit;False;1574.327;869.0638;;17;274;76;232;262;191;176;236;238;190;75;164;239;264;265;266;189;161;各向异性高光;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;271;-449.1577,-170.8649;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;116;654.7882,674.2842;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;115;674.7947,528.0892;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;263;-320.5425,-174.8001;Inherit;True;_AnisotropyVar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;-47.15563,-243.8695;Float;False;Property;_Anisotropy1Rang;各向异性1范围;11;0;Create;False;0;0;0;False;0;False;3.5;1.6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;119;657.7197,815.5618;Float;False;Property;_AnisotropySpecRang;各向异性高光范围;8;0;Create;False;0;0;0;False;0;False;0.01;0.3;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;117;854.3765,582.955;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-45.88848,-26.63197;Float;False;Property;_Anisotropy2Rang;各向异性2范围;12;0;Create;False;0;0;0;False;0;False;7.5;4;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;264;112.6082,-153.9786;Inherit;False;263;_AnisotropyVar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;273;979.4221,582.7809;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Exp2OpNode;266;219.5607,-21.67052;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;276;969.3621,655.9863;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;11;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Exp2OpNode;265;216.5607,-238.6703;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;75;370.7734,-435.5496;Float;False;Property;_Anisotropy1SpecColor;各向异性1高光颜色;9;0;Create;False;0;0;0;False;0;False;0.9632353,0.9038391,0.8499135,0;0.5471698,0.3639194,0.3639194,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;190;351.5372,-45.94872;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;164;345.5052,-263.1777;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;118;1124.524,583.2371;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;239;380.9693,166.448;Float;False;Property;_Anisotropy2SpecColor1;各向异性2高光颜色;10;1;[HDR];Create;False;0;0;0;False;0;False;0.9632353,0.9038391,0.8499135,0;0.5188679,0.482823,0.4527857,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;176;600.6503,155.8537;Inherit;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;65;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;261;1271.95,577.2705;Inherit;False;_SpecRangeVar;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;238;617.2404,-346.7212;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;236;620.9753,45.1492;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;191;786.8997,-149.5216;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;262;792.0629,-11.8042;Inherit;False;261;_SpecRangeVar;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;232;941.4879,204.0751;Float;False;Property;_AO;AO;6;0;Create;False;0;0;0;False;0;False;1;True;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;1128.407,-52.89318;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;274;1260.182,-59.63565;Inherit;True;_AnisotropySpecVar;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;221;2670.518,-88.40792;Float;False;Property;_Color;基础色;0;1;[HDR];Create;False;0;0;0;False;0;False;0.9779412,0.7868161,0.6831207,0.997;1,1,1,0.997;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;257;2581.142,-280.1312;Inherit;True;Property;_BaseMap;基础图;2;0;Create;False;0;0;0;False;0;False;-1;None;51a20ed79cac47b4a88df5505de3dc64;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;277;2615.057,86.29567;Inherit;False;Property;_Brightness;亮度;1;0;Create;False;0;0;0;False;0;False;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;2655.059,171.2822;Inherit;False;Property;_BumpScale;法线强度;4;0;Create;False;0;0;0;False;0;False;1;0.5;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;256;2933.789,-155.3295;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;275;2900.88,-244.7555;Inherit;False;274;_AnisotropySpecVar;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;136;2931.514,122.4216;Inherit;True;Property;_BumpMap;法线图;3;0;Create;False;0;0;0;False;0;False;-1;None;551b2b916266a2f4082d3ffd3546e3fc;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;268;2957.366,320.5341;Inherit;False;Property;_Cutoff;Cutoff;15;0;Create;True;0;0;0;True;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;2948.212,35.60127;Float;False;Property;_Smoothness;平滑度;14;0;Create;False;0;0;0;False;0;False;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;2948.966,-46.40846;Float;False;Property;_Metallic;金属度;13;0;Create;False;0;0;0;False;0;False;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;258;3153.36,-210.8434;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;278;3330.419,-87.41561;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Hair_Anisotropic;False;False;False;False;False;False;False;False;False;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;7;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;268;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;235;0;65;2
WireConnection;235;1;77;0
WireConnection;79;0;65;1
WireConnection;79;1;235;0
WireConnection;138;0;137;0
WireConnection;138;1;79;0
WireConnection;140;0;139;0
WireConnection;140;1;138;0
WireConnection;156;0;140;0
WireConnection;156;1;155;0
WireConnection;148;0;156;0
WireConnection;148;1;156;0
WireConnection;159;0;148;0
WireConnection;271;0;159;0
WireConnection;263;0;271;0
WireConnection;117;0;115;0
WireConnection;117;1;116;0
WireConnection;273;0;117;0
WireConnection;266;0;189;0
WireConnection;276;2;119;0
WireConnection;265;0;161;0
WireConnection;190;0;264;0
WireConnection;190;1;266;0
WireConnection;164;0;264;0
WireConnection;164;1;265;0
WireConnection;118;0;273;0
WireConnection;118;1;276;0
WireConnection;261;0;118;0
WireConnection;238;0;75;0
WireConnection;238;1;164;0
WireConnection;236;0;190;0
WireConnection;236;1;239;0
WireConnection;191;0;238;0
WireConnection;191;1;236;0
WireConnection;232;1;176;3
WireConnection;76;0;191;0
WireConnection;76;1;232;0
WireConnection;76;2;262;0
WireConnection;274;0;76;0
WireConnection;256;0;257;0
WireConnection;256;1;221;0
WireConnection;256;2;277;0
WireConnection;136;5;255;0
WireConnection;258;0;275;0
WireConnection;258;1;256;0
WireConnection;278;0;258;0
WireConnection;278;1;136;0
WireConnection;278;3;135;0
WireConnection;278;4;120;0
WireConnection;278;10;257;4
ASEEND*/
//CHKSM=8C7E72042ED08FA3D3D27FA50FB1CAF2C3C34E5F