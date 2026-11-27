package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol709")]
   public dynamic class frysauce_sourcream extends MovieClip
   {
      
      public var icon:MovieClip;
      
      public var timer_txt:TextField;
      
      public function frysauce_sourcream()
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

