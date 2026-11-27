package package_2
{
   import flash.display.*;
   import flash.utils.*;
   
   public class class_14
   {
      
      public function class_14()
      {
         super();
      }
      
      public function method_103(param1:String) : MovieClip
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         var _loc3_:MovieClip = new _loc2_() as MovieClip;
         _loc3_.tabEnabled = false;
         return _loc3_;
      }
      
      public function method_136(param1:String) : SimpleButton
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         var _loc3_:SimpleButton = new _loc2_() as SimpleButton;
         _loc3_.tabEnabled = false;
         return _loc3_;
      }
      
      public function method_221(param1:String, param2:*, param3:*, param4:Object = null) : *
      {
         var _loc5_:Class = null;
         _loc5_ = getDefinitionByName(param1) as Class;
         return new _loc5_(param2,param3,param4);
      }
   }
}

