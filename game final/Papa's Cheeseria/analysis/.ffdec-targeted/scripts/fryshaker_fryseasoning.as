package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol14811")]
   public dynamic class fryshaker_fryseasoning extends MovieClip
   {
      
      public var icon:MovieClip;
      
      public var timer_txt:TextField;
      
      public function fryshaker_fryseasoning()
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

