Shader "Ex/BumpEnvironment"
{
	Properties
	{
		_myDiffuse( "Diffuse texture", 2D ) = "white" {}
		_myBump( "Bump texture", 2D ) = "bump" {}
		_myCube( "Cube", CUBE ) = "" {}
		_mySlider( "Bump amount", Range( 0, 10 ) ) = 1
		_myBright( "Brightness", Range( 0, 10 ) ) = 1
	}

	SubShader
	{
		CGPROGRAM
			// Type shader - function to call - lighting model
			#pragma surface main Lambert 

			struct Input
			{
				float2 uv_myDiffuse;
				float2 uv_myBump;
				// Will contain world reflection vector if surface shader writes to o.Normal.
				// To get the reflection vector based on per-pixel normal map, use 
				// WorldReflectionVector( IN, o.Normal ).
				float3 worldRefl; INTERNAL_DATA
			};

			sampler2D   _myDiffuse;
			sampler2D   _myBump;
			samplerCUBE _myCube;
			float _mySlider;
			float _myBright;

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
				o.Albedo = ( tex2D( _myDiffuse, IN.uv_myDiffuse ) * _myBright ).rgb;
				o.Normal = UnpackNormal( tex2D( _myBump, IN.uv_myBump ) );
				o.Normal *= float3( _mySlider, _mySlider, 1 );
				o.Emission = texCUBE( _myCube, WorldReflectionVector( IN, o.Normal ) ).rgb;

				/*
				// CHALLENGE: metallic reflective bump mapped surface.
				o.Albedo = texCUBE( _myCube, WorldReflectionVector( IN, o.Normal ) ).rgb;
				o.Normal = UnpackNormal( tex2D( _myBump, IN.uv_myBump ) );
				o.Normal *= float3( _mySlider, _mySlider, 1 );
				*/
			}

		ENDCG
	}

	Fallback "Diffuse"
}