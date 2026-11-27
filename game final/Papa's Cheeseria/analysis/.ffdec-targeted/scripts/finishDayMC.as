package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8771")]
   public dynamic class finishDayMC extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var cheeseria:MovieClip;
      
      public var customercross:customerMC;
      
      public var fg:MovieClip;
      
      public var insideholder:MovieClip;
      
      public var lampposts:MovieClip;
      
      public var lamppostsbg:MovieClip;
      
      public var tradingpost:MovieClip;
      
      public var tradingpostbg:MovieClip;
      
      public var workerholder:MovieClip;
      
      public function finishDayMC()
      {
         super();
         addFrameScript(99,this.frame100);
      }
      
      internal function frame100() : *
      {
         stop();
      }
   }
}

