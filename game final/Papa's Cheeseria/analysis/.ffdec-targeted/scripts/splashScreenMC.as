package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol14098")]
   public dynamic class splashScreenMC extends MovieClip
   {
      
      public var cheeses:MovieClip;
      
      public var fader:MovieClip;
      
      public var fries:MovieClip;
      
      public var iris:MovieClip;
      
      public function splashScreenMC()
      {
         super();
         addFrameScript(31,this.frame32);
      }
      
      internal function frame32() : *
      {
         stop();
      }
   }
}

