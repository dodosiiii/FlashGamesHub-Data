package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol13683")]
   public dynamic class frysauce_ketchup extends MovieClip
   {
      
      public var icon:MovieClip;
      
      public var timer_txt:TextField;
      
      public function frysauce_ketchup()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

