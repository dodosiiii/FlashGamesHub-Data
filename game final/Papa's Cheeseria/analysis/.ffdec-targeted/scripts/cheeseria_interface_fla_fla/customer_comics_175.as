package cheeseria_interface_fla_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3473")]
   public dynamic class customer_comics_175 extends MovieClip
   {
      
      public function customer_comics_175()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         gotoAndStop(1 + Math.ceil(Math.random() * 4));
      }
   }
}

