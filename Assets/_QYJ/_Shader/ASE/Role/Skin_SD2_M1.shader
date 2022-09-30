// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Skin_SD2_M1"
{
	Properties
	{
		_Color("颜色", Color) = (1,1,1,1)
		_Brightness("补光", Float) = 0
		_BaseMap("基础图", 2D) = "white" {}
		_BumpMap("法线图", 2D) = "bump" {}
		_BumpScale("法线强度", Range( -2 , 2)) = 1
		_MaskMap("遮罩图（RGB高光A平滑度）", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 1
		_SmoothnessMin("平滑度Min", Range( 0 , 0.5)) = 0.5
		_SmoothnessMax("平滑度Max", Range( 0.5 , 1)) = 0.5
		_AO("AO", Range( 0 , 1)) = 1
		_SSSMap("SSSMap", 2D) = "black" {}
		_SSSUOfsset("SSSUOfsset", Range( 0 , 1)) = 0
		_SSSVOffset("SSSVOffset", Range( 0 , 1)) = 1
		_SSSColor("SSS颜色", Color) = (0,0,0,0)
		_SSSIntensity("SSS强度", Range( 0 , 10)) = 1
		_SSSMask("SSS遮罩图", 2D) = "white" {}
		_RampMap("RampMap", 2D) = "white" {}
		[KeywordEnum(RampMap,SSS)] _Keyword0("Keyword 0", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _KEYWORD0_RAMPMAP _KEYWORD0_SSS
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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _BumpScale;
		uniform float4 _Color;
		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform float _Brightness;
		uniform float _SSSIntensity;
		uniform sampler2D _SSSMap;
		uniform float _SSSUOfsset;
		uniform float _SSSVOffset;
		uniform sampler2D _SSSMask;
		uniform float4 _SSSMask_ST;
		uniform float4 _SSSColor;
		uniform sampler2D _RampMap;
		uniform float _Metallic;
		uniform sampler2D _MaskMap;
		uniform float4 _MaskMap_ST;
		uniform float _SmoothnessMin;
		uniform float _SmoothnessMax;
		uniform float _AO;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale );
			float2 uv_BaseMap = i.uv_texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw;
			float4 _BaseVar55 = ( _Color * tex2D( _BaseMap, uv_BaseMap ) );
			o.Albedo = _BaseVar55.rgb;
			float4 temp_output_19_0 = ( _BaseVar55 * _Brightness );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult49 = normalize( ase_worldViewDir );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float dotResult26 = dot( normalizeResult49 , ase_worldNormal );
			float2 appendResult33 = (float2(( _SSSUOfsset + ( 1.0 - ( 0.5 + ( dotResult26 * 0.5 ) ) ) ) , _SSSVOffset));
			float2 uv_SSSMask = i.uv_texcoord * _SSSMask_ST.xy + _SSSMask_ST.zw;
			float4 _SSSVar52 = ( _SSSIntensity * tex2D( _SSSMap, appendResult33 ) * tex2D( _SSSMask, uv_SSSMask ).r * _SSSColor );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult68 = dot( ase_worldlightDir , ase_worldNormal );
			float temp_output_73_0 = ( ( dotResult68 * 0.5 ) + 0.5 );
			float2 appendResult75 = (float2(temp_output_73_0 , temp_output_73_0));
			float4 _RampVar77 = tex2D( _RampMap, appendResult75 );
			#if defined(_KEYWORD0_RAMPMAP)
				float4 staticSwitch80 = ( _RampVar77 * temp_output_19_0 );
			#elif defined(_KEYWORD0_SSS)
				float4 staticSwitch80 = ( temp_output_19_0 + _SSSVar52 );
			#else
				float4 staticSwitch80 = ( temp_output_19_0 + _SSSVar52 );
			#endif
			o.Emission = staticSwitch80.rgb;
			float2 uv_MaskMap = i.uv_texcoord * _MaskMap_ST.xy + _MaskMap_ST.zw;
			float4 tex2DNode13 = tex2D( _MaskMap, uv_MaskMap );
			o.Metallic = ( _Metallic * tex2DNode13.r );
			o.Smoothness = (_SmoothnessMin + (( 1.0 - tex2DNode13.g ) - -1.0) * (_SmoothnessMax - _SmoothnessMin) / (1.0 - -1.0));
			o.Occlusion = ( tex2DNode13.b * _AO );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu switch nomrt 
		#pragma surface surf Standard keepalpha fullforwardshadows exclude_path:deferred nofog noforwardadd 

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
126;769;1531;733;5399.192;661.8024;3.75982;True;False
Node;AmplifyShaderEditor.CommentaryNode;58;-3358.44,140.8261;Inherit;False;1776.235;567.7219;;17;41;50;49;26;30;31;34;40;33;45;35;44;43;52;84;85;86;SSS;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;41;-3499.44,271.7188;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;49;-3297.901,277.8615;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;50;-3331.1,368.7613;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;26;-3136.512,314.8492;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-3019.955,353.5676;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-2891.955,281.5677;Inherit;False;2;2;0;FLOAT;0.5;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;66;-3010.361,1019.218;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;69;-2963.298,1170.438;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;40;-2769.003,281.1669;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;68;-2751.298,1092.438;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-2880.008,198.0473;Inherit;False;Property;_SSSUOfsset;SSSUOfsset;11;0;Create;False;0;0;0;False;0;False;0;0.2595294;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;-2560.42,256.5276;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-2625.298,1134.438;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2707.849,371.7208;Inherit;False;Property;_SSSVOffset;SSSVOffset;12;0;Create;True;0;0;0;False;0;False;1;0.4588235;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;60;-3356.266,-527.777;Inherit;False;741.8354;451.0002;;4;9;8;10;55;基础;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;33;-2428.997,313.1429;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;8;-3216.266,-477.7766;Inherit;False;Property;_Color;颜色;0;0;Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-3306.266,-306.7763;Inherit;True;Property;_BaseMap;基础图;2;0;Create;False;0;0;0;False;0;False;-1;None;50488ef2aeecd4347a8ead569ea78dbb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-2484.298,1161.438;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;75;-2352.297,1148.438;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2273.53,190.8261;Inherit;False;Property;_SSSIntensity;SSS强度;14;0;Create;False;0;0;0;False;0;False;1;2.45;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-2293.642,478.548;Inherit;True;Property;_SSSMask;SSS遮罩图;15;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-2991.265,-377.7766;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;86;-1947.497,482.5476;Inherit;False;Property;_SSSColor;SSS颜色;13;0;Create;False;0;0;0;False;0;False;0,0,0,0;0.8014706,0.5657439,0.5657439,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;35;-2293.997,284.1429;Inherit;True;Property;_SSSMap;SSSMap;10;0;Create;True;0;0;0;False;0;False;-1;None;7f04ae9ecb1caae4187ec6c378872dc9;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1960.906,264.2597;Inherit;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;74;-2208.297,1120.438;Inherit;True;Property;_RampMap;RampMap;16;0;Create;True;0;0;0;False;0;False;-1;None;271f5ee3273dd7f4fae6e204d4f8c4bf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-2838.43,-382.5691;Inherit;False;_BaseVar;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-1031.529,-128.3541;Inherit;False;55;_BaseVar;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-1884.738,1119.75;Inherit;False;_RampVar;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;-1678.205,259.2726;Inherit;False;_SSSVar;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1002.294,-50.77684;Inherit;False;Property;_Brightness;补光;1;0;Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-880.9591,22.89067;Inherit;False;52;_SSSVar;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-895.3171,-231.9427;Inherit;False;77;_RampVar;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-851.4939,-93.57684;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-1099.899,458.1064;Inherit;True;Property;_MaskMap;遮罩图（RGB高光A平滑度）;5;0;Create;False;0;0;0;False;0;False;-1;None;14c7d2c375649a84196af93e60611e1c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;82;-1071.852,718.775;Inherit;False;Property;_SmoothnessMax;平滑度Max;8;0;Create;False;0;0;0;False;0;False;0.5;0.5;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-1075.973,348.9144;Inherit;False;Property;_Metallic;Metallic;6;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-667.4521,-31.64438;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-673.0172,-148.9427;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1074.199,645.3071;Inherit;False;Property;_SmoothnessMin;平滑度Min;7;0;Create;False;0;0;0;False;0;False;0.5;0.5;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1070.373,797.8232;Inherit;False;Property;_AO;AO;9;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1018.337,176.0269;Inherit;False;Property;_BumpScale;法线强度;4;0;Create;False;0;0;0;False;0;False;1;0.5;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;83;-799.417,520.8995;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;80;-512.4795,-102.5397;Inherit;False;Property;_Keyword0;Keyword 0;17;0;Create;True;0;0;0;False;0;False;0;1;1;True;;KeywordEnum;2;RampMap;SSS;Create;False;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-742.3729,776.8232;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-754.0812,353.2968;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-745.3373,129.0269;Inherit;True;Property;_BumpMap;法线图;3;0;Create;False;0;0;0;False;0;False;-1;None;e7f2138295c99c241a7841dfa18a39ff;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;57;-507.9891,-346.3549;Inherit;False;55;_BaseVar;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;81;-632.8523,505.775;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;61;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Skin_SD2_M1;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;8;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;0;41;0
WireConnection;26;0;49;0
WireConnection;26;1;50;0
WireConnection;30;0;26;0
WireConnection;31;1;30;0
WireConnection;40;0;31;0
WireConnection;68;0;66;0
WireConnection;68;1;69;0
WireConnection;84;0;85;0
WireConnection;84;1;40;0
WireConnection;72;0;68;0
WireConnection;33;0;84;0
WireConnection;33;1;34;0
WireConnection;73;0;72;0
WireConnection;75;0;73;0
WireConnection;75;1;73;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;35;1;33;0
WireConnection;43;0;44;0
WireConnection;43;1;35;0
WireConnection;43;2;45;1
WireConnection;43;3;86;0
WireConnection;74;1;75;0
WireConnection;55;0;10;0
WireConnection;77;0;74;0
WireConnection;52;0;43;0
WireConnection;19;0;56;0
WireConnection;19;1;20;0
WireConnection;51;0;19;0
WireConnection;51;1;53;0
WireConnection;78;0;79;0
WireConnection;78;1;19;0
WireConnection;83;0;13;2
WireConnection;80;1;78;0
WireConnection;80;0;51;0
WireConnection;64;0;13;3
WireConnection;64;1;65;0
WireConnection;17;0;63;0
WireConnection;17;1;13;1
WireConnection;11;5;12;0
WireConnection;81;0;83;0
WireConnection;81;3;16;0
WireConnection;81;4;82;0
WireConnection;61;0;57;0
WireConnection;61;1;11;0
WireConnection;61;2;80;0
WireConnection;61;3;17;0
WireConnection;61;4;81;0
WireConnection;61;5;64;0
ASEEND*/
//CHKSM=F3125067583E0AE87A2CE5DDFD8F0E2393CFCC8F