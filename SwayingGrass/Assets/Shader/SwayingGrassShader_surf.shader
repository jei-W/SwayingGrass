Shader "Custom/SurfaceShader/SwayingGrass"
{
    Properties
    {
		_MainTex ("Albedo", 2D) = "white" {}
		_EmissionTex ("Emission", 2D) = "black" {}
		_BumpMap ("Normal", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM

        #pragma surface surf Lambert vertex:vert addshadow

		void vert (inout appdata_full v)
		{
			v.vertex.y += sin(_Time.y * 2.2) * 0.1 * v.color.r;
			v.vertex.x += sin(_Time.y) * 0.1 * v.color.r;

		}

        struct Input
        {
			fixed4 color : COLOR;

            float2 uv_MainTex;
			float2 uv_BumpMap;
        };

		sampler2D _MainTex;
		sampler2D _EmissionTex;
		sampler2D _BumpMap;

        void surf (Input IN, inout SurfaceOutput o)
        {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);

			o.Albedo = c.rgb;
			o.Alpha = c.a;
			o.Emission = tex2D(_EmissionTex, IN.uv_MainTex);
			o.Normal = UnpackNormal( tex2D(_BumpMap, IN.uv_BumpMap) );
        }
        ENDCG
    }
    FallBack "Diffuse"
}
