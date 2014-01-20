package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.flixel.system.FlxPreloader;

	public class Preloader extends FlxPreloader
	{
		private var bmp:Bitmap;
		public function Preloader()
		{
			className = "MainWeb2P";
			super();
		}
		
		override protected function create():void {

			_buffer = new Sprite();
			addChild(_buffer);
			//Add stuff to the buffer...
			
			//_buffer = new Sprite();
			_buffer.scaleX = 2;
			_buffer.scaleY = 2;
			//addChild(_buffer);
			_width = stage.stageWidth/_buffer.scaleX;
			_height = stage.stageHeight/_buffer.scaleY;
			_buffer.addChild(new Bitmap(new BitmapData(_width,_height,false,0x000000)));
			var bitmap:Bitmap = new ImgLogoLight();
			bitmap.smoothing = true;
			bitmap.width = bitmap.height = _height;
			bitmap.x = (_width-bitmap.width)/2;
			//_buffer.addChild(bitmap);
			//_bmpBar = new Bitmap(new BitmapData(1,7,false,0x5f6aff));
			//_bmpBar.x = 4;
			//_bmpBar.y = _height-11;
			//_buffer.addChild(_bmpBar);
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat("system",8,0x5f6aff);
			_text.embedFonts = true;
			_text.selectable = false;
			_text.multiline = false;
			_text.x = 2;
			_text.y = 2;
			_text.width = 80;
			_buffer.addChild(_text);
			_logo = new ImgLogo();
			_logo.scaleX = _logo.scaleY = _height/8;
			_logo.x = (_width-_logo.width)/2;
			_logo.y = (_height-_logo.height)/2;
			//_buffer.addChild(_logo);
			_logoGlow = new ImgLogo();
			_logoGlow.smoothing = true;
			_logoGlow.blendMode = "screen";
			_logoGlow.scaleX = _logoGlow.scaleY = _height/8;
			_logoGlow.x = (_width-_logoGlow.width)/2;
			_logoGlow.y = (_height-_logoGlow.height)/2;
			//_buffer.addChild(_logoGlow);
			bitmap = new ImgLogoCorners();
			bitmap.smoothing = true;
			bitmap.width = _width;
			bitmap.height = _height;
			//_buffer.addChild(bitmap);
			bitmap = new Bitmap(new BitmapData(_width,_height,false,0xffffff));
			var i:uint = 0;
			var j:uint = 0;
			while(i < _height)
			{
				j = 0;
				while(j < _width)
					bitmap.bitmapData.setPixel(j++,i,0);
				i+=2;
			}
			bitmap.blendMode = "overlay";
			bitmap.alpha = 0.25;
			//_buffer.addChild(bitmap);
			

			bmp = new Bitmap(new BitmapData(1,7,false,0xffffff));
			bmp.x = 4;
			bmp.y = _height-11;
			_buffer.addChild(bmp);
			
			
		}
		override protected function update(Percent:Float):void {
			//Update the graphics...
			bmp.scaleX = Percent * (_width - 8);
		}
		
	}
}

