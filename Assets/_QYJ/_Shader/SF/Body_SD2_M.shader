// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:False,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:32719,y:32712,varname:node_2865,prsc:2|diff-6343-OUT,spec-6973-OUT,gloss-4751-OUT,normal-9261-OUT,emission-1815-OUT;n:type:ShaderForge.SFN_Multiply,id:6343,x:32414,y:32565,varname:node_6343,prsc:2|A-7736-RGB,B-6665-RGB;n:type:ShaderForge.SFN_Color,id:6665,x:32221,y:32698,ptovrint:True,ptlb:颜色,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7736,x:32221,y:32473,ptovrint:True,ptlb:基础图,ptin:_BaseMap,varname:_BaseMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:5964,x:30331,y:32112,ptovrint:True,ptlb:法线图,ptin:_BumpMap,varname:_BumpMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Slider,id:358,x:30273,y:32535,ptovrint:True,ptlb:金属度强度,ptin:_MetallicIntensity,varname:_MetallicIntensity,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1813,x:30273,y:33048,ptovrint:True,ptlb:平滑度最小值,ptin:_SmoothnessMin,varname:_SmoothnessMin,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.5;n:type:ShaderForge.SFN_Slider,id:1643,x:30443,y:32276,ptovrint:True,ptlb:法线强度,ptin:_BumpScale,varname:_BumpScale,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-2,cur:1,max:2;n:type:ShaderForge.SFN_Append,id:1266,x:30565,y:32129,varname:node_1266,prsc:2|A-5964-R,B-5964-G;n:type:ShaderForge.SFN_Multiply,id:1741,x:30775,y:32129,varname:node_1741,prsc:2|A-1266-OUT,B-1643-OUT;n:type:ShaderForge.SFN_Append,id:6458,x:30945,y:32129,varname:node_6458,prsc:2|A-1741-OUT,B-5964-B;n:type:ShaderForge.SFN_Tex2d,id:9537,x:30430,y:32672,ptovrint:True,ptlb:遮罩图,ptin:_MaskMap,varname:_MaskMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:123,x:30873,y:32610,varname:node_123,prsc:2|A-358-OUT,B-9537-R;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:1965,x:30874,y:32867,varname:node_1965,prsc:2|IN-9537-G,IMIN-4578-OUT,IMAX-6370-OUT,OMIN-1813-OUT,OMAX-9750-OUT;n:type:ShaderForge.SFN_Vector1,id:6370,x:30430,y:32970,varname:node_6370,prsc:2,v1:1;n:type:ShaderForge.SFN_Slider,id:9750,x:30273,y:33186,ptovrint:True,ptlb:平滑度最大值,ptin:_SmoothnessMax,varname:_SmoothnessMax,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.5,cur:1,max:1;n:type:ShaderForge.SFN_Vector1,id:4578,x:30430,y:32875,varname:node_4578,prsc:2,v1:-1;n:type:ShaderForge.SFN_Set,id:4863,x:31105,y:32129,varname:_NormalVar,prsc:2|IN-6458-OUT;n:type:ShaderForge.SFN_Get,id:9261,x:32393,y:32869,varname:node_9261,prsc:2|IN-4863-OUT;n:type:ShaderForge.SFN_Set,id:8363,x:31063,y:32610,varname:_MetallicVar,prsc:2|IN-123-OUT;n:type:ShaderForge.SFN_Set,id:1173,x:31062,y:32867,varname:_SmoothnessVar,prsc:2|IN-1965-OUT;n:type:ShaderForge.SFN_Get,id:6973,x:32393,y:32732,varname:node_6973,prsc:2|IN-8363-OUT;n:type:ShaderForge.SFN_Get,id:4751,x:32393,y:32801,varname:node_4751,prsc:2|IN-1173-OUT;n:type:ShaderForge.SFN_Cubemap,id:1377,x:31888,y:32988,ptovrint:False,ptlb:Cubemap,ptin:_Cubemap,varname:_Cubemap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0;n:type:ShaderForge.SFN_Multiply,id:4114,x:32065,y:33098,varname:node_4114,prsc:2|A-1377-RGB,B-4993-OUT;n:type:ShaderForge.SFN_Slider,id:4993,x:31731,y:33200,ptovrint:True,ptlb:环境图强度,ptin:_EnvIntensity,varname:_EnvIntensity,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_Tex2d,id:490,x:31888,y:33350,ptovrint:False,ptlb:Matcap,ptin:_Matcap,varname:_Matcap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3127-OUT;n:type:ShaderForge.SFN_Multiply,id:762,x:32065,y:33280,varname:node_762,prsc:2|A-4993-OUT,B-490-RGB;n:type:ShaderForge.SFN_NormalVector,id:3253,x:31042,y:33350,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:4226,x:31211,y:33350,varname:node_4226,prsc:2,tffrom:0,tfto:3|IN-3253-OUT;n:type:ShaderForge.SFN_ComponentMask,id:512,x:31373,y:33350,varname:node_512,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-4226-XYZ;n:type:ShaderForge.SFN_Multiply,id:9498,x:31547,y:33350,varname:node_9498,prsc:2|A-512-OUT,B-5438-OUT;n:type:ShaderForge.SFN_Add,id:3127,x:31719,y:33350,varname:node_3127,prsc:2|A-9498-OUT,B-5438-OUT;n:type:ShaderForge.SFN_Vector1,id:5438,x:31373,y:33498,varname:half,prsc:2,v1:0.5;n:type:ShaderForge.SFN_ToggleProperty,id:1833,x:32254,y:33067,ptovrint:True,ptlb:开启环境图,ptin:_Env,varname:_Env,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Multiply,id:1815,x:32454,y:33121,varname:node_1815,prsc:2|A-1833-OUT,B-1110-OUT;n:type:ShaderForge.SFN_Lerp,id:1110,x:32304,y:33203,varname:node_1110,prsc:2|A-4114-OUT,B-762-OUT,T-3093-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:3093,x:32065,y:33471,ptovrint:True,ptlb:0Cube 1Matcap,ptin:_CubeOrMatcap,varname:_CubeOrMatcap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;proporder:6665-7736-5964-1643-9537-358-1813-9750-1833-4993-3093-1377-490;pass:END;sub:END;*/

Shader "VG/Shader Forge/Role/Body_SD2_M" {
    Properties {
        _Color ("颜色", Color) = (1,1,1,1)
        _BaseMap ("基础图", 2D) = "white" {}
        _BumpMap ("法线图", 2D) = "bump" {}
        _BumpScale ("法线强度", Range(-2, 2)) = 1
        _MaskMap ("遮罩图", 2D) = "white" {}
        _MetallicIntensity ("金属度强度", Range(0, 1)) = 0
        _SmoothnessMin ("平滑度最小值", Range(0, 0.5)) = 0
        _SmoothnessMax ("平滑度最大值", Range(0.5, 1)) = 1
        [MaterialToggle] _Env ("开启环境图", Float ) = 0
        _EnvIntensity ("环境图强度", Range(0, 2)) = 1
        [MaterialToggle] _CubeOrMatcap ("0Cube 1Matcap", Float ) = 0
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _Matcap ("Matcap", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _BaseMap; uniform float4 _BaseMap_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform float _MetallicIntensity;
            uniform float _SmoothnessMin;
            uniform float _BumpScale;
            uniform sampler2D _MaskMap; uniform float4 _MaskMap_ST;
            uniform float _SmoothnessMax;
            uniform samplerCUBE _Cubemap;
            uniform float _EnvIntensity;
            uniform sampler2D _Matcap; uniform float4 _Matcap_ST;
            uniform fixed _Env;
            uniform fixed _CubeOrMatcap;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD9;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
                float3 _NormalVar = float3((float2(_BumpMap_var.r,_BumpMap_var.g)*_BumpScale),_BumpMap_var.b);
                float3 normalLocal = _NormalVar;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _MaskMap_var = tex2D(_MaskMap,TRANSFORM_TEX(i.uv0, _MaskMap));
                float node_4578 = (-1.0);
                float _SmoothnessVar = (_SmoothnessMin + ( (_MaskMap_var.g - node_4578) * (_SmoothnessMax - _SmoothnessMin) ) / (1.0 - node_4578));
                float gloss = _SmoothnessVar;
                float perceptualRoughness = 1.0 - _SmoothnessVar;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float _MetallicVar = (_MetallicIntensity*_MaskMap_var.r);
                float3 specularColor = _MetallicVar;
                float specularMonochrome;
                float4 _BaseMap_var = tex2D(_BaseMap,TRANSFORM_TEX(i.uv0, _BaseMap));
                float3 diffuseColor = (_BaseMap_var.rgb*_Color.rgb); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float half = 0.5;
                float2 node_3127 = ((mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg*half)+half);
                float4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_3127, _Matcap));
                float3 emissive = (_Env*lerp((texCUBE(_Cubemap,viewReflectDirection).rgb*_EnvIntensity),(_EnvIntensity*_Matcap_var.rgb),_CubeOrMatcap));
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _BaseMap; uniform float4 _BaseMap_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform float _MetallicIntensity;
            uniform float _SmoothnessMin;
            uniform float _BumpScale;
            uniform sampler2D _MaskMap; uniform float4 _MaskMap_ST;
            uniform float _SmoothnessMax;
            uniform samplerCUBE _Cubemap;
            uniform float _EnvIntensity;
            uniform sampler2D _Matcap; uniform float4 _Matcap_ST;
            uniform fixed _Env;
            uniform fixed _CubeOrMatcap;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _BumpMap_var = UnpackNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)));
                float3 _NormalVar = float3((float2(_BumpMap_var.r,_BumpMap_var.g)*_BumpScale),_BumpMap_var.b);
                float3 normalLocal = _NormalVar;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 _MaskMap_var = tex2D(_MaskMap,TRANSFORM_TEX(i.uv0, _MaskMap));
                float node_4578 = (-1.0);
                float _SmoothnessVar = (_SmoothnessMin + ( (_MaskMap_var.g - node_4578) * (_SmoothnessMax - _SmoothnessMin) ) / (1.0 - node_4578));
                float gloss = _SmoothnessVar;
                float perceptualRoughness = 1.0 - _SmoothnessVar;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float _MetallicVar = (_MetallicIntensity*_MaskMap_var.r);
                float3 specularColor = _MetallicVar;
                float specularMonochrome;
                float4 _BaseMap_var = tex2D(_BaseMap,TRANSFORM_TEX(i.uv0, _BaseMap));
                float3 diffuseColor = (_BaseMap_var.rgb*_Color.rgb); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
