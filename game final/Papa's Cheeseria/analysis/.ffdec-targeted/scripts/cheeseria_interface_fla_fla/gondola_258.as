package cheeseria_interface_fla_fla
{
   import flash.display.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol15266")]
   public dynamic class gondola_258 extends MovieClip
   {
      
      public var back_forearm:MovieClip;
      
      public var back_hair:MovieClip;
      
      public var back_shoe:MovieClip;
      
      public var back_upperarm:MovieClip;
      
      public var backhand:MovieClip;
      
      public var body:MovieClip;
      
      public var eyes:MovieClip;
      
      public var front_forearm:MovieClip;
      
      public var front_shoe:MovieClip;
      
      public var front_upperarm:MovieClip;
      
      public var fronthand:MovieClip;
      
      public var hair:MovieClip;
      
      public var head:MovieClip;
      
      public var mouth:MovieClip;
      
      public var neck:MovieClip;
      
      public var passenger:customerMC;
      
      public function gondola_258()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         try
         {
            MovieClip(this.mouth.getChildAt(0)).gotoAndStop(1);
            MovieClip(this.eyes.getChildAt(0)).gotoAndStop(1);
            MovieClip(this.fronthand.getChildAt(0)).gotoAndStop(6);
            MovieClip(this.front_shoe.getChildAt(0)).gotoAndStop(1);
            MovieClip(this.back_shoe.getChildAt(0)).gotoAndStop(1);
            MovieClip(this.backhand.getChildAt(0)).gotoAndStop(2);
         }
         catch(err:*)
         {
         }
      }
   }
}

