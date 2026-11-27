package cheeseria_gameassets_fla_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7375")]
   public dynamic class giveorder_dining_scorebubbles_289 extends MovieClip
   {
      
      public var build_score:MovieClip;
      
      public var cook_score:MovieClip;
      
      public var fry_score:MovieClip;
      
      public var order_score:MovieClip;
      
      public var perfect:MovieClip;
      
      public var total_score:MovieClip;
      
      public function giveorder_dining_scorebubbles_289()
      {
         super();
         addFrameScript(92,this.frame93,107,this.frame108);
      }
      
      internal function frame93() : *
      {
         this.perfect.gotoAndPlay("fireworks");
      }
      
      internal function frame108() : *
      {
         stop();
      }
   }
}

