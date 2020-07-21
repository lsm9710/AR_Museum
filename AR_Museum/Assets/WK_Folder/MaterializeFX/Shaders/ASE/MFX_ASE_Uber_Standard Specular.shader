// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "QFX/MFX/ASE/Uber/Standard Specular"
{
	Properties
	{
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionMap("Emission Texture", 2D) = "white" {}
		[HDR]_FringeEmissionColor("Fringe Emission Color", Color) = (0,0,0,1)
		[HDR]_EmissionColor2("Emission Color 2", Color) = (1,1,1,1)
		_EmissionMap2("Emission Texture 2", 2D) = "white" {}
		_EmissionMap2_Scroll("Emission Texture 2 Scroll", Vector) = (0,0,0,0)
		_EmissionSize2("Emission Size 2", Range( 0 , 1)) = 0.32633
		[Toggle]_EmissionSmooth2("EmissionSmooth2?", Float) = 1
		[HDR]_EdgeColor("Edge Color", Color) = (1,1,1,1)
		_EdgeRampMap1("Edge Ramp Map", 2D) = "white" {}
		_EdgeRampMap1_Scroll("Edge Ramp Map Scroll", Vector) = (0,0,0,0)
		_FringeEmissionMap_Scroll("FringeEmissionMap Scroll", Vector) = (0,0,0,0)
		_FringeRampMap_Scroll("Fringe Ramp Map Scroll", Vector) = (0,0,0,0)
		_EdgeSize("Edge Size", Range( 0 , 2)) = 0.5
		_DissolveMap1("Dissolve Map", 2D) = "white" {}
		_DissolveMap1_Scroll("Dissolve Map Scroll", Vector) = (0,0,0,0)
		_DissolveSize("Dissolve Size", Range( 0 , 5)) = 2
		[HDR]_DissolveEdgeColor("Dissolve Edge Color", Color) = (1,1,1,1)
		_DissolveEdgeSize("Dissolve Edge Size", Range( 0 , 2)) = 0
		_FringeEmissionMap("Fringe Emission Map", 2D) = "white" {}
		_FringeRampMap("Fringe Ramp Map", 2D) = "white" {}
		_FringeSize("Fringe Size", Float) = 0
		_FringeOffset("Fringe Offset", Float) = 0
		_FringeAmount("Fringe Amount", Float) = 0
		_MaskOffset("Mask Offset", Float) = 1.04
		[Toggle]_Invert("Invert", Float) = 0
		[KeywordEnum(None,AxisLocal,AxisGlobal,Global)] _MaskType("Mask Type", Float) = 2
		[KeywordEnum(X,Y,Z)] _CutoffAxis("Cutoff Axis", Float) = 1
		_WorldPositionOffset("World Position Offset", Vector) = (0,0,0,0)
		_MaskWorldPosition("Mask World Position", Vector) = (0,0,0,0)
		_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpScale("Bump Scale", Float) = 1
		[HDR]_FringeColor("Fringe Color", Color) = (0,0,0,1)
		[HDR]_Color2("Albedo Color 2", Color) = (0,0,0,1)
		_MainTex2("Albedo 2", 2D) = "white" {}
		_BumpMap2("Normal Map 2", 2D) = "bump" {}
		[HDR]_Color("Albedo Color", Color) = (1,1,1,1)
		[KeywordEnum(SpecularAlpha,AlbedoAlpha)] _SmoothnessTextureChannel("Smoothness Texture Channel", Float) = 0
		[Toggle(_SPECGLOSSMAP_ON)] _SPECGLOSSMAP("SPECGLOSSMAP", Float) = 0
		_Cutoff( "Mask Clip Value", Float ) = 0.1
		[HDR]_SpecColor("Specular Color", Color) = (1,1,1,1)
		_MainTex("Albedo", 2D) = "white" {}
		_GlossMapScale("Smoothness Scale", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0
		_SpecGlossMap("Specular Texture", 2D) = "white" {}
		_OcclusionMap("Occlusion", 2D) = "white" {}
		_OcclusionStrength("Occlusion", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature _CUTOFFAXIS_X _CUTOFFAXIS_Y _CUTOFFAXIS_Z
		#pragma shader_feature _MASKTYPE_NONE _MASKTYPE_AXISLOCAL _MASKTYPE_AXISGLOBAL _MASKTYPE_GLOBAL
		#pragma shader_feature _SPECGLOSSMAP_ON
		#pragma shader_feature _SMOOTHNESSTEXTURECHANNEL_SPECULARALPHA _SMOOTHNESSTEXTURECHANNEL_ALBEDOALPHA
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float2 uv2_texcoord2;
		};

		uniform sampler2D _FringeRampMap;
		uniform float2 _FringeRampMap_Scroll;
		uniform float4 _FringeRampMap_ST;
		uniform float _FringeAmount;
		uniform float _FringeSize;
		uniform float _FringeOffset;
		uniform float3 _WorldPositionOffset;
		uniform float3 _MaskWorldPosition;
		uniform float _Invert;
		uniform float _MaskOffset;
		uniform sampler2D _EdgeRampMap1;
		uniform float2 _EdgeRampMap1_Scroll;
		uniform float4 _EdgeRampMap1_ST;
		uniform float _EdgeSize;
		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _BumpMap2;
		uniform float4 _BumpMap2_ST;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color2;
		uniform sampler2D _MainTex2;
		uniform float4 _MainTex2_ST;
		uniform float4 _FringeColor;
		uniform float _DissolveSize;
		uniform sampler2D _DissolveMap1;
		uniform float2 _DissolveMap1_Scroll;
		uniform float4 _DissolveMap1_ST;
		uniform float _DissolveEdgeSize;
		uniform float4 _DissolveEdgeColor;
		uniform float4 _EmissionColor;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float _EmissionSmooth2;
		uniform float4 _EmissionColor2;
		uniform sampler2D _EmissionMap2;
		uniform float2 _EmissionMap2_Scroll;
		uniform float4 _EmissionMap2_ST;
		uniform float _EmissionSize2;
		uniform float4 _EdgeColor;
		uniform sampler2D _FringeEmissionMap;
		uniform float2 _FringeEmissionMap_Scroll;
		uniform float4 _FringeEmissionMap_ST;
		uniform float4 _FringeEmissionColor;
		uniform float _Glossiness;
		uniform float _GlossMapScale;
		uniform sampler2D _SpecGlossMap;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;
		uniform float _Cutoff = 0.1;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_FringeRampMap = v.texcoord.xy * _FringeRampMap_ST.xy + _FringeRampMap_ST.zw;
			float2 panner57_g22 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g22 = tex2Dlod( _FringeRampMap, float4( panner57_g22, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			float temp_output_87_0_g22 = ( 1.0 - _FringeSize );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_4_0_g22 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_cast_1 = (length( ( temp_output_4_0_g22 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g22 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g22 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g22 = temp_output_4_0_g22;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g22 = temp_cast_1;
			#else
				float3 staticSwitch10_g22 = temp_output_4_0_g22;
			#endif
			float3 break13_g22 = staticSwitch10_g22;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g22 = break13_g22.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g22 = break13_g22.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g22 = break13_g22.z;
			#else
				float staticSwitch20_g22 = break13_g22.y;
			#endif
			float mfx_pos25_g22 = staticSwitch20_g22;
			float mfx_invert_option23_g22 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g22 = ( mfx_invert_option23_g22 * _MaskOffset );
			float mfx_mask_pos40_g22 = ( ( mfx_pos25_g22 * mfx_invert_option23_g22 ) - temp_output_28_0_g22 );
			float mfx_mask_offset38_g22 = temp_output_28_0_g22;
			float temp_output_78_0_g22 = ( ( _FringeOffset + ( mfx_mask_pos40_g22 - mfx_mask_offset38_g22 ) ) - tex2DNode68_g22.r );
			float smoothstepResult110_g22 = smoothstep( temp_output_87_0_g22 , ( temp_output_87_0_g22 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g22 ) ));
			float2 uv_EdgeRampMap1 = v.texcoord.xy * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g22 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g22 = v.texcoord.xy + panner27_g22;
			float mfx_edge_pos55_g22 = ( mfx_mask_pos40_g22 - ( temp_output_28_0_g22 - tex2Dlod( _EdgeRampMap1, float4( uv_TexCoord31_g22, 0, 0.0) ).r ) );
			float temp_output_84_0_g22 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g22 ) ) );
			float mfx_edge_threshold108_g22 = temp_output_84_0_g22;
			float temp_output_66_0_g22 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g22 = smoothstep( temp_output_66_0_g22 , ( temp_output_66_0_g22 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g22 ) ));
			float mfx_edge119_g22 = saturate( ( smoothstepResult85_g22 - temp_output_84_0_g22 ) );
			float mfx_fringe_threshold170_g22 = ( saturate( ( smoothstepResult110_g22 - saturate( ( 1.0 - ceil( temp_output_78_0_g22 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g22 ) - mfx_edge119_g22 ) );
			float3 mfx_local_vert_offset184_g22 = ( tex2DNode68_g22.r * ( ase_vertexNormal * _FringeAmount ) * mfx_fringe_threshold170_g22 );
			v.vertex.xyz += mfx_local_vert_offset184_g22;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv2_BumpMap2 = i.uv2_texcoord2 * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_4_0_g22 = ( ase_worldPos - _WorldPositionOffset );
			float3 temp_cast_0 = (1.0).xxx;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 temp_cast_1 = (length( ( temp_output_4_0_g22 - _MaskWorldPosition ) )).xxx;
			#if defined(_MASKTYPE_NONE)
				float3 staticSwitch10_g22 = temp_cast_0;
			#elif defined(_MASKTYPE_AXISLOCAL)
				float3 staticSwitch10_g22 = ase_vertex3Pos;
			#elif defined(_MASKTYPE_AXISGLOBAL)
				float3 staticSwitch10_g22 = temp_output_4_0_g22;
			#elif defined(_MASKTYPE_GLOBAL)
				float3 staticSwitch10_g22 = temp_cast_1;
			#else
				float3 staticSwitch10_g22 = temp_output_4_0_g22;
			#endif
			float3 break13_g22 = staticSwitch10_g22;
			#if defined(_CUTOFFAXIS_X)
				float staticSwitch20_g22 = break13_g22.x;
			#elif defined(_CUTOFFAXIS_Y)
				float staticSwitch20_g22 = break13_g22.y;
			#elif defined(_CUTOFFAXIS_Z)
				float staticSwitch20_g22 = break13_g22.z;
			#else
				float staticSwitch20_g22 = break13_g22.y;
			#endif
			float mfx_pos25_g22 = staticSwitch20_g22;
			float mfx_invert_option23_g22 = lerp(1.0,-1.0,_Invert);
			float temp_output_28_0_g22 = ( mfx_invert_option23_g22 * _MaskOffset );
			float mfx_mask_pos40_g22 = ( ( mfx_pos25_g22 * mfx_invert_option23_g22 ) - temp_output_28_0_g22 );
			float2 uv_EdgeRampMap1 = i.uv_texcoord * _EdgeRampMap1_ST.xy + _EdgeRampMap1_ST.zw;
			float2 panner27_g22 = ( 1.0 * _Time.y * _EdgeRampMap1_Scroll + uv_EdgeRampMap1);
			float2 uv_TexCoord31_g22 = i.uv_texcoord + panner27_g22;
			float mfx_edge_pos55_g22 = ( mfx_mask_pos40_g22 - ( temp_output_28_0_g22 - tex2D( _EdgeRampMap1, uv_TexCoord31_g22 ).r ) );
			float temp_output_84_0_g22 = saturate( ( 1.0 - ceil( mfx_edge_pos55_g22 ) ) );
			float mfx_edge_threshold108_g22 = temp_output_84_0_g22;
			float temp_output_32_0_g24 = mfx_edge_threshold108_g22;
			float3 lerpResult28_g24 = lerp( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale ) , UnpackNormal( tex2D( _BumpMap2, uv2_BumpMap2 ) ) , temp_output_32_0_g24);
			float3 mfx_norma14_g24 = lerpResult28_g24;
			o.Normal = mfx_norma14_g24;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 uv_MainTex2 = i.uv_texcoord * _MainTex2_ST.xy + _MainTex2_ST.zw;
			float4 lerpResult9_g24 = lerp( ( _Color * tex2D( _MainTex, uv_MainTex ) ) , ( _Color2 * tex2D( _MainTex2, uv_MainTex2 ) ) , temp_output_32_0_g24);
			float temp_output_87_0_g22 = ( 1.0 - _FringeSize );
			float mfx_mask_offset38_g22 = temp_output_28_0_g22;
			float2 uv_FringeRampMap = i.uv_texcoord * _FringeRampMap_ST.xy + _FringeRampMap_ST.zw;
			float2 panner57_g22 = ( 1.0 * _Time.y * _FringeRampMap_Scroll + uv_FringeRampMap);
			float4 tex2DNode68_g22 = tex2D( _FringeRampMap, panner57_g22 );
			float temp_output_78_0_g22 = ( ( _FringeOffset + ( mfx_mask_pos40_g22 - mfx_mask_offset38_g22 ) ) - tex2DNode68_g22.r );
			float smoothstepResult110_g22 = smoothstep( temp_output_87_0_g22 , ( temp_output_87_0_g22 + 0.1 ) , ( 1.0 - abs( temp_output_78_0_g22 ) ));
			float temp_output_66_0_g22 = ( 1.0 - _EdgeSize );
			float smoothstepResult85_g22 = smoothstep( temp_output_66_0_g22 , ( temp_output_66_0_g22 + 0.1 ) , ( 1.0 - abs( mfx_edge_pos55_g22 ) ));
			float mfx_edge119_g22 = saturate( ( smoothstepResult85_g22 - temp_output_84_0_g22 ) );
			float mfx_fringe_threshold170_g22 = ( saturate( ( smoothstepResult110_g22 - saturate( ( 1.0 - ceil( temp_output_78_0_g22 ) ) ) ) ) * ( ( 1.0 - mfx_edge_threshold108_g22 ) - mfx_edge119_g22 ) );
			float4 lerpResult12_g24 = lerp( lerpResult9_g24 , _FringeColor , mfx_fringe_threshold170_g22);
			float4 myVarName18_g24 = lerpResult12_g24;
			o.Albedo = myVarName18_g24.rgb;
			float2 uv_DissolveMap1 = i.uv_texcoord * _DissolveMap1_ST.xy + _DissolveMap1_ST.zw;
			float2 panner83_g22 = ( 1.0 * _Time.y * _DissolveMap1_Scroll + uv_DissolveMap1);
			float mfx_alpha141_g22 = ( _DissolveSize + ( mfx_mask_pos40_g22 - ( temp_output_28_0_g22 - tex2D( _DissolveMap1, panner83_g22 ).r ) ) );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 uv_EmissionMap2 = i.uv_texcoord * _EmissionMap2_ST.xy + _EmissionMap2_ST.zw;
			float2 panner22_g22 = ( 1.0 * _Time.y * _EmissionMap2_Scroll + uv_EmissionMap2);
			float4 tex2DNode29_g22 = tex2D( _EmissionMap2, panner22_g22 );
			float clampResult53_g22 = clamp( ( ( ( 1.0 - tex2DNode29_g22.r ) - 0.5 ) * 3.0 ) , 0.0 , 1.0 );
			float4 mfx_emission_297_g22 = lerp(( _EmissionColor2 * tex2DNode29_g22.r ),( _EmissionColor2 * ( pow( clampResult53_g22 , 3.0 ) * saturate( ( ( mfx_mask_pos40_g22 - mfx_mask_offset38_g22 ) + (0.0 + (_EmissionSize2 - 0.0) * (3.0 - 0.0) / (1.0 - 0.0)) ) ) ) ),_EmissionSmooth2);
			float4 lerpResult113_g22 = lerp( ( _EmissionColor * tex2D( _EmissionMap, uv_EmissionMap ) ) , mfx_emission_297_g22 , mfx_edge_threshold108_g22);
			float4 mfx_emission129_g22 = lerpResult113_g22;
			float2 uv_FringeEmissionMap = i.uv_texcoord * _FringeEmissionMap_ST.xy + _FringeEmissionMap_ST.zw;
			float2 panner116_g22 = ( 1.0 * _Time.y * _FringeEmissionMap_Scroll + uv_FringeEmissionMap);
			float4 mfx_fringe_emission161_g22 = ( tex2D( _FringeEmissionMap, panner116_g22 ) * _FringeEmissionColor );
			float4 lerpResult177_g22 = lerp( (( mfx_alpha141_g22 <= _DissolveEdgeSize ) ? _DissolveEdgeColor :  ( mfx_emission129_g22 + ( _EdgeColor * mfx_edge119_g22 ) ) ) , mfx_fringe_emission161_g22 , mfx_fringe_threshold170_g22);
			float4 mfx_final_emission181_g22 = lerpResult177_g22;
			o.Emission = mfx_final_emission181_g22.rgb;
			float4 break37_g23 = _SpecColor;
			float4 appendResult23_g23 = (float4(break37_g23.r , break37_g23.g , break37_g23.b , _Glossiness));
			float temp_output_33_0_g23 = _GlossMapScale;
			float temp_output_38_0_g23 = _Color.a;
			float4 appendResult17_g23 = (float4(break37_g23.r , break37_g23.g , break37_g23.b , ( temp_output_33_0_g23 * temp_output_38_0_g23 )));
			#if defined(_SMOOTHNESSTEXTURECHANNEL_SPECULARALPHA)
				float staticSwitch10_g23 = 0.0;
			#elif defined(_SMOOTHNESSTEXTURECHANNEL_ALBEDOALPHA)
				float staticSwitch10_g23 = 1.0;
			#else
				float staticSwitch10_g23 = 0.0;
			#endif
			float texturechannel18_g23 = staticSwitch10_g23;
			float4 lerpResult25_g23 = lerp( appendResult23_g23 , appendResult17_g23 , texturechannel18_g23);
			float4 break35_g23 = tex2D( _SpecGlossMap, uv_MainTex );
			float4 appendResult21_g23 = (float4(break35_g23.r , break35_g23.g , break35_g23.b , ( break35_g23.a * temp_output_33_0_g23 )));
			float4 appendResult22_g23 = (float4(break35_g23.r , break35_g23.g , break35_g23.b , ( temp_output_33_0_g23 * temp_output_38_0_g23 )));
			float4 lerpResult24_g23 = lerp( appendResult21_g23 , appendResult22_g23 , texturechannel18_g23);
			#ifdef _SPECGLOSSMAP_ON
				float4 staticSwitch26_g23 = lerpResult24_g23;
			#else
				float4 staticSwitch26_g23 = lerpResult25_g23;
			#endif
			float4 break27_g23 = staticSwitch26_g23;
			float3 appendResult28_g23 = (float3(break27_g23.x , break27_g23.y , break27_g23.z));
			float3 Specular122 = appendResult28_g23;
			o.Specular = Specular122;
			float Smoothness121 = break27_g23.w;
			o.Smoothness = Smoothness121;
			float lerpResult128 = lerp( 1.0 , tex2D( _OcclusionMap, uv_MainTex ).r , _OcclusionStrength);
			float occlusion129 = lerpResult128;
			o.Occlusion = occlusion129;
			o.Alpha = 1;
			clip( mfx_alpha141_g22 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "MfxShaderGui"
}
/*ASEBEGIN
Version=15600
245;88;1478;896;4597.236;891.2269;2.74086;True;False
Node;AmplifyShaderEditor.CommentaryNode;125;-3322.319,858.9627;Float;False;832.5983;527.703;;5;562;129;128;126;127;Ambient Occlusion;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-3340.674,-689.2037;Float;False;1780.834;731.0764;;7;117;121;122;555;815;816;817;Specular & Smoothness;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;139;-3320.385,153.1452;Float;False;608.3228;625.7384;;4;29;28;27;561;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;562;-3281.852,957.5607;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;555;-3260.619,-566.5344;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;561;-3239.689,588.5475;Float;False;0;28;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;126;-3283.401,1078.061;Float;True;Property;_OcclusionMap;Occlusion;50;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;-3160.203,237.3555;Float;False;Property;_Color;Albedo Color;40;1;[HDR];Create;False;0;0;False;0;1,1,1,1;0.8235294,0.8235294,0.8235294,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;817;-2988.712,-93.46239;Float;False;Property;_GlossMapScale;Smoothness Scale;47;0;Create;False;0;0;False;0;0;0.917;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;815;-2919.588,-395.6862;Float;False;Property;_SpecColor;Specular Color;45;1;[HDR];Fetch;False;0;0;False;0;1,1,1,1;0.8235294,0.8235294,0.8235294,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;127;-3283.401,1286.06;Float;False;Property;_OcclusionStrength;Occlusion;51;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;816;-2989.776,-175.7242;Float;False;Property;_Glossiness;Smoothness;48;0;Create;False;0;0;False;0;0;0.917;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;117;-3008.983,-590.2652;Float;True;Property;_SpecGlossMap;Specular Texture;49;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;28;-3240.816,404.1202;Float;True;Property;_MainTex;Albedo;46;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;821;-2574.544,-384.1932;Float;False;GetSpecularSmoothness;41;;23;bad312ca98f83b74eb4775f8556ee7b7;0;5;34;COLOR;0,0,0,0;False;36;COLOR;0,0,0,0;False;32;FLOAT;0;False;33;FLOAT;0;False;38;FLOAT;0;False;2;FLOAT3;0;FLOAT;31
Node;AmplifyShaderEditor.LerpOp;128;-2944.271,1154.463;Float;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-2880.561,384.9582;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;822;-2660.454,329.1183;Float;False;GetMfxSingle;0;;22;9c3f88100a75314498e512de6691ced0;0;1;217;COLOR;0,0,0,0;False;5;COLOR;199;FLOAT;201;FLOAT3;200;FLOAT;222;FLOAT;223
Node;AmplifyShaderEditor.RegisterLocalVarNode;129;-2760.172,1151.04;Float;False;occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;130;-2070.423,861.786;Float;False;129;occlusion;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;823;-2287.095,150.2191;Float;False;GetMfxAlbedoNormal;31;;24;0ed64765209a0d24ba3cbdf31229ebcf;0;5;32;FLOAT;0;False;33;FLOAT;0;False;30;COLOR;0,0,0,0;False;18;FLOAT3;0,0,0;False;22;COLOR;0,0,0,0;False;2;COLOR;0;FLOAT3;35
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-2045.965,-326.3509;Float;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-2041.952,-429.075;Float;False;Specular;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-2063.866,698.689;Float;False;122;Specular;0;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-2082.467,782.1889;Float;False;121;Smoothness;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1779.987,284.4162;Float;False;True;2;Float;MfxShaderGui;0;0;StandardSpecular;QFX/MFX/ASE/Uber/Standard Specular;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.1;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;44;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;405;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;126;1;562;0
WireConnection;117;1;555;0
WireConnection;28;1;561;0
WireConnection;821;34;117;0
WireConnection;821;36;815;0
WireConnection;821;32;816;0
WireConnection;821;33;817;0
WireConnection;821;38;27;4
WireConnection;128;1;126;1
WireConnection;128;2;127;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;129;0;128;0
WireConnection;823;32;822;222
WireConnection;823;33;822;223
WireConnection;823;22;29;0
WireConnection;121;0;821;31
WireConnection;122;0;821;0
WireConnection;0;0;823;0
WireConnection;0;1;823;35
WireConnection;0;2;822;199
WireConnection;0;3;123;0
WireConnection;0;4;124;0
WireConnection;0;5;130;0
WireConnection;0;10;822;201
WireConnection;0;11;822;200
ASEEND*/
//CHKSM=80623D3971040DEF3FC2909EAB2026A5513FFD73