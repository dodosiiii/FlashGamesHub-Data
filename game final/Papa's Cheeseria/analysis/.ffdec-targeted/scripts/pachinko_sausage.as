package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1783")]
   public dynamic class pachinko_sausage extends MovieClip
   {
      
      public function pachinko_sausage()
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

