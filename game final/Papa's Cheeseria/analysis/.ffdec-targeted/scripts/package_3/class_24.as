package package_3
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import flipline.api.class_17;
   
   public class class_24
   {
      
      private var clip:MovieClip;
      
      private var api:class_17;
      
      private var var_292:Boolean = false;
      
      private var var_263:Number = -1;
      
      private var timer:Timer = null;
      
      public function class_24(param1:class_17, param2:String, param3:Boolean = false, param4:Number = -1)
      {
         var _loc5_:class_24 = null;
         super();
         _loc5_ = this;
         _loc5_.api = param1;
         _loc5_.var_292 = param3;
         _loc5_.var_263 = param4;
         _loc5_.setupScreen(param2);
      }
      
      public function setupScreen(param1:String) : void
      {
         var _loc2_:class_24 = this;
         _loc2_.clip = new saveBannerMC();
         if(_loc2_.var_292)
         {
            _loc2_.clip.message_txt.htmlText = String(param1);
         }
         else
         {
            _loc2_.clip.message_txt.text = String(param1);
         }
         if(_loc2_.var_263 > 0)
         {
            _loc2_.timer = new Timer(_loc2_.var_263,1);
            _loc2_.timer.addEventListener(TimerEvent.TIMER,_loc2_.method_132);
            _loc2_.timer.start();
            _loc2_.clip.close_btn.visible = false;
         }
         else
         {
            _loc2_.clip.close_btn.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.method_132);
         }
         MovieClip(_loc2_.api.var_281).addChild(_loc2_.clip);
      }
      
      public function method_132(param1:Event = null) : void
      {
         var _loc2_:class_24 = this;
         _loc2_.api.method_130();
      }
      
      public function destroy() : void
      {
         var _loc1_:class_24 = this;
         if(_loc1_.timer != null)
         {
            _loc1_.timer.stop();
            _loc1_.timer.removeEventListener(TimerEvent.TIMER,_loc1_.method_132);
            _loc1_.timer = null;
         }
         _loc1_.clip.close_btn.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.method_132);
         _loc1_.clip.parent.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}

