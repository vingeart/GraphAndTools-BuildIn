// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Body_SD2_M"
{
	Properties
	{
		_Color("颜色", Color) = (1,1,1,1)
		_BaseMap("基础图", 2D) = "white" {}
		_BumpMap("法线图", 2D) = "bump" {}
		_BumpScale("法线强度", Range( -2 , 2)) = 1
		_MaskMap("遮罩图(R金属度G粗糙度)", 2D) = "white" {}
		_MetallicIntensity("金属度强度", Range( 0 , 1)) = 0
		_SmoothnessMin("平滑度Min", Range( 0 , 0.5)) = 0
		_SmoothnessMax("平滑度Max", Range( 0.5 , 1)) = 1
		_AO("AO", Range( 0 , 2)) = 0
		_CubeMap("CubeMap", CUBE) = "white" {}
		_CubeIntensity("CubeIntensity", Range( 0 , 3)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu switch nomrt 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 uv_texcoord;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _BumpScale;
		uniform float4 _Color;
		uniform sampler2D _BaseMap;
		uniform float4 _BaseMap_ST;
		uniform float _CubeIntensity;
		uniform samplerCUBE _CubeMap;
		uniform float4 _CubeMap_ST;
		uniform float _MetallicIntensity;
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
			o.Albedo = ( _Color * tex2D( _BaseMap, uv_BaseMap ) ).rgb;
			float3 uv_CubeMap3 = i.uv_texcoord;
			uv_CubeMap3.xy = i.uv_texcoord.xy * _CubeMap_ST.xy + _CubeMap_ST.zw;
			float2 uv_MaskMap = i.uv_texcoord * _MaskMap_ST.xy + _MaskMap_ST.zw;
			float4 tex2DNode6 = tex2D( _MaskMap, uv_MaskMap );
			float temp_output_7_0 = ( _MetallicIntensity * tex2DNode6.r );
			float temp_output_10_0 = (_SmoothnessMin + (tex2DNode6.g - -1.0) * (_SmoothnessMax - _SmoothnessMin) / (1.0 - -1.0));
			o.Emission = ( ( _CubeIntensity * texCUBE( _CubeMap, uv_CubeMap3 ) ) * temp_output_7_0 * temp_output_10_0 ).rgb;
			o.Metallic = temp_output_7_0;
			o.Smoothness = temp_output_10_0;
			o.Occlusion = ( tex2DNode6.b * _AO );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
282;956;1531;733;2137.94;-209.5897;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-884.6018,409.0192;Inherit;False;Property;_MetallicIntensity;金属度强度;5;0;Create;False;0;0;0;False;0;False;0;0.75;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-887.0491,807.7492;Inherit;False;Property;_SmoothnessMax;平滑度Max;7;0;Create;False;0;0;0;False;0;False;1;0.7;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-904.2743,501.5013;Inherit;True;Property;_MaskMap;遮罩图(R金属度G粗糙度);4;0;Create;False;0;0;0;False;0;False;-1;None;abc0dbc2c9d42504ba28b0235e46a555;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-1672.648,425.5909;Inherit;True;Property;_CubeMap;CubeMap;9;0;Create;True;0;0;0;False;0;False;-1;None;56a68e301a0ff55469ae441c0112d256;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-887.0491,727.7492;Inherit;False;Property;_SmoothnessMin;平滑度Min;6;0;Create;False;0;0;0;False;0;False;0;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1656.77,333.1284;Inherit;False;Property;_CubeIntensity;CubeIntensity;10;0;Create;True;0;0;0;False;0;False;0;0.2;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-556.9332,460.3139;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-654.5,-228.5;Inherit;False;Property;_Color;颜色;0;0;Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1273.994,381.6443;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;10;-552.0492,662.7492;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-885.0643,938.1633;Inherit;False;Property;_AO;AO;8;0;Create;True;0;0;0;False;0;False;0;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-739.5,-59.5;Inherit;True;Property;_BaseMap;基础图;1;0;Create;False;0;0;0;False;0;False;-1;None;cdd97f9ad9e198c409f6508c35059c5a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1000.337,236.0113;Inherit;False;Property;_BumpScale;法线强度;3;0;Create;False;0;0;0;False;0;False;1;1;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-351.1927,377.1536;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-509.5742,886.4489;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-710.4366,189.211;Inherit;True;Property;_BumpMap;法线图;2;0;Create;False;0;0;0;False;0;False;-1;None;1b5d22d2314ea3c4d85291ff310cad47;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-414.5,-141.5;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-23.55173,304.9597;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Body_SD2_M;False;False;False;False;False;False;False;False;False;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;8;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;8;0
WireConnection;7;1;6;1
WireConnection;16;0;17;0
WireConnection;16;1;15;0
WireConnection;10;0;6;2
WireConnection;10;3;11;0
WireConnection;10;4;12;0
WireConnection;18;0;16;0
WireConnection;18;1;7;0
WireConnection;18;2;10;0
WireConnection;13;0;6;3
WireConnection;13;1;14;0
WireConnection;4;5;5;0
WireConnection;2;0;3;0
WireConnection;2;1;1;0
WireConnection;0;0;2;0
WireConnection;0;1;4;0
WireConnection;0;2;18;0
WireConnection;0;3;7;0
WireConnection;0;4;10;0
WireConnection;0;5;13;0
ASEEND*/
//CHKSM=9A5339877B150F12DCA4D41B754019D8A4C91224