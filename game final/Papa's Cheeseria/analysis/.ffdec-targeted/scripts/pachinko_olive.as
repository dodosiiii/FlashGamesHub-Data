package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol10669")]
   public dynamic class pachinko_olive extends MovieClip
   {
      
      public function pachinko_olive()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame10() : *
      {
         gotoAndStop(1);
      }
   }
}

