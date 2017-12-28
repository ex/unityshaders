Shader "Ex/BumpMapping"
{
	Properties
	{
		_myDiffuse( "Diffuse texture", 2D ) = "white" {}
		_myBump ( "Bump texture", 2D ) = "bump" {}
		_myFactorX( "Gain X", Range( 0, 10 ) ) = 1
		_myFactorY( "Gain Y", Range( 0, 10 ) ) = 1
		_myColor( "Diffuse color", Color ) = ( 1, 1, 1, 1 )
	    _myFactorD( "Diffuse factor", Range( 0, 2 ) ) = 1
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface main Lambert // Type shader - function to call - lighting model

			struct Input
			{
				float2 uv_myDiffuse;
				float2 uv_myBump;
			};

			sampler2D _myDiffuse;
			sampler2D _myBump;
			half      _myFactorX;
			half      _myFactorY;
			fixed4    _myColor;
			half      _myFactorD;

			void main( Input IN, inout SurfaceOutput o )
			{
				o.Albedo = ( _myFactorD * tex2D( _myDiffuse, IN.uv_myDiffuse ) + _myColor ).rgb;
				o.Normal = UnpackNormal( tex2D( _myBump, IN.uv_myBump ) );
				o.Normal.x *= _myFactorX;
				o.Normal.y *= _myFactorY;
			}

		ENDCG
	}

	Fallback "Diffuse"
}