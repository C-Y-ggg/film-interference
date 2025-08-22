Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Matcap("Matcap",2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal_world : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _Matcap

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                float3 normal_world = mul(float4(v.normal,0.0),unity_WorldToObject);
                o.normal_world = normal_world;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half3 normal_world = normalize(i.normal_world);
                half3 normal_viewspace = mul(UNITY_MATRIX_V,float4(normal_world, 0.0)).xyz;
                half3 matcap_color = tex2D(_Matcap, half2(0.5 + 0.5 * normal_viewspace.x, 0.5 + 0.5 * normal_viewspace.y)).rgb;
                col.rgb *= matcap_color;

                return col;
            }
            ENDCG
        }
    }
}
