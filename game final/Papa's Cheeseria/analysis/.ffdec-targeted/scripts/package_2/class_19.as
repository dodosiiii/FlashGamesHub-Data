package package_2
{
   public class class_19
   {
      
      public function class_19()
      {
         super();
      }
      
      public static function method_120(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_] is Array)
               {
                  _loc3_[_loc2_] = class_19.method_120(param1[_loc2_]);
               }
               else
               {
                  _loc3_[_loc2_] = param1[_loc2_];
               }
               _loc2_++;
            }
         }
         return _loc3_;
      }
      
      public static function getRandom(param1:Array) : *
      {
         return param1[Math.floor(Math.random() * param1.length)];
      }
   }
}

