package cheeseria_interface_fla_fla
{
   import flash.display.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3606")]
   public dynamic class outside_gondola_584 extends MovieClip
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
      
      public var passenger:customerBleachersMC;
      
      public function outside_gondola_584()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame1() : *
      {
         try
         {
            MovieClip(this.mouth.getChildAt(0)).gotoAndStop(5);
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
      
      internal function frame2() : *
      {
         try
         {
            MovieClip(this.mouth.getChildAt(0)).gotoAndStop(5);
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

