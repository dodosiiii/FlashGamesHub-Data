package cheeseria_gameassets_fla_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2850")]
   public dynamic class fry_oil_205 extends MovieClip
   {
      
      public var boostboil:MovieClip;
      
      public function fry_oil_205()
      {
         super();
         addFrameScript(0,this.frame1,42,this.frame43,50,this.frame51);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame43() : *
      {
         gotoAndPlay("loop");
      }
      
      internal function frame51() : *
      {
         gotoAndStop("static");
      }
   }
}

