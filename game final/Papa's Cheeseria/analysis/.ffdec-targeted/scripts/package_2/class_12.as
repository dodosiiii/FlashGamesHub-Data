package package_2
{
   import flash.display.*;
   import flash.utils.*;
   
   public class class_12
   {
      
      public function class_12()
      {
         super();
      }
      
      public static function method_103(param1:String, param2:Boolean = true, param3:Boolean = true) : MovieClip
      {
         var _loc4_:MovieClip = null;
         var _loc5_:Class = null;
         _loc5_ = getDefinitionByName(param1) as Class;
         _loc4_ = new _loc5_() as MovieClip;
         _loc4_.tabEnabled = false;
         _loc4_.mouseEnabled = param2;
         _loc4_.mouseChildren = param3;
         return _loc4_;
      }
      
      public static function method_161(param1:String, param2:Boolean = true, param3:Boolean = true) : DisplayObject
      {
         var _loc4_:* = undefined;
         var _loc5_:Class = null;
         _loc5_ = getDefinitionByName(param1) as Class;
         _loc4_ = new _loc5_();
         if(_loc4_ is BitmapData)
         {
            return new Bitmap(_loc4_,"auto",true);
         }
         if(_loc4_ is MovieClip)
         {
            _loc4_.tabEnabled = false;
            _loc4_.mouseEnabled = param2;
            _loc4_.mouseChildren = param3;
            return _loc4_;
         }
         return _loc4_;
      }
   }
}

