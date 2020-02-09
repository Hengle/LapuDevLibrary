﻿Shader "Custom/UIshader"
{
    Properties
    {
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1, 0, 0, 0)
	}
		
	SubShader
		{
			Tags { "RenderType" = "Opaque" }

			Pass
			{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _Color;
			float4 _MainTex_ST;

		struct appdata
		{
			float4 vertex : POSITION;
			float2 texcoord : TEXCOORD0;
			float3 normal : NORMAL;
		};

		struct v2f
		{
			float4 pos : SV_POSITION;
			float2 texcoord : TEXCOORD0;
			float3 cubenormal : TEXCOORD1;
			UNITY_FOG_COORDS(2)
		};

		v2f vert(appdata v)
		{
			v2f o;
			o.pos = UnityObjectToClipPos(v.vertex);
			o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{
			fixed4 col = _Color * tex2D(_MainTex, i.texcoord);
			return col;
		}

		ENDCG
		}
	}
}
