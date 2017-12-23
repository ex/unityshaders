Shader "Ex/HelloShader"
{
	Properties
	{
		_myColor ( "Example color", Color ) = ( 1, 1, 1, 1 )
		_myEmission ( "Example emission", Color ) = ( 1, 1, 1, 1 )
		_myNormal ( "Example normal", Color ) = ( 1, 1, 1, 1 )
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface main Lambert // Type shader - function to call - lighting model

			struct Input
			{
				float2 uvMainTex;
			};

			fixed4 _myColor; // In order to use property must be declared inside CGPROGRAM
			fixed4 _myEmission;
			fixed4 _myNormal;

			/*
			Struct SurfaceOutput
			{
				fixed3 Albedo;   // diffuse color
				fixed3 Normal;   // tanget space normal, if written
				fixed3 Emission;
				half   Specular; // specular power in  0..1 range
				fixed  Gloss;    // specular itensity
				fixed Alpha;     // alpha for transparency
			}
			*/
			void main( Input IN, inout SurfaceOutput o )
			{
				o.Albedo = _myColor.rgb;
				o.Emission = _myEmission.rgb;
				o.Normal = _myNormal.rgb;
			}

		ENDCG
	}

	Fallback "Diffuse"
}