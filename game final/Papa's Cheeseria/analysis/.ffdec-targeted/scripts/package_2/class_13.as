package package_2
{
   public class class_13
   {
      
      public function class_13()
      {
         super();
      }
      
      public static function method_110(param1:Number) : String
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:String = String(param1);
         var _loc4_:String = "";
         var _loc5_:* = int(_loc3_.length - 1);
         while(_loc5_ >= 0)
         {
            _loc2_ = _loc3_.length - 1 - _loc5_;
            if(_loc2_ % 3 == 0 && _loc2_ > 0 && _loc3_.charAt(_loc5_) != "-")
            {
               _loc4_ = "," + _loc4_;
            }
            _loc4_ = _loc3_.charAt(_loc5_) + _loc4_;
            _loc5_--;
         }
         return _loc4_;
      }
      
      public static function method_127(param1:Number) : String
      {
         var _loc5_:String = null;
         var _loc2_:String = "";
         var _loc3_:Number = Math.floor(param1 / 100);
         var _loc4_:Number = param1 - _loc3_ * 100;
         _loc5_ = String(_loc4_);
         if(_loc5_.length < 2)
         {
            _loc5_ = "0" + _loc5_;
         }
         return "$" + _loc3_ + "." + _loc5_;
      }
      
      public static function method_226(param1:Number, param2:Boolean = true, param3:Boolean = false) : String
      {
         var _loc4_:Number = param1;
         var _loc5_:* = "";
         var _loc6_:Number = 0;
         if(param3)
         {
            _loc6_ = Math.floor(param1 / 30 / 60 / 60);
            _loc4_ -= _loc6_ * 30 * 60 * 60;
         }
         var _loc7_:Number = Math.floor(_loc4_ / 30 / 60);
         _loc4_ -= _loc7_ * 30 * 60;
         var _loc8_:Number = Math.floor(_loc4_ / 30);
         _loc4_ -= _loc8_ * 30;
         var _loc9_:Number = Math.round(_loc4_ / 30 * 100);
         if(param3)
         {
            if(_loc6_ < 10)
            {
               _loc5_ += "0";
            }
            _loc5_ += String(_loc6_) + ":";
         }
         if(_loc7_ < 10)
         {
            _loc5_ += "0";
         }
         _loc5_ += String(_loc7_) + ":";
         if(_loc8_ < 10)
         {
            _loc5_ += "0";
         }
         _loc5_ += String(_loc8_);
         if(param2)
         {
            _loc5_ += ":";
            if(_loc9_ < 10)
            {
               _loc5_ += "0";
            }
            _loc5_ += String(_loc9_);
         }
         return _loc5_;
      }
      
      public static function method_185(param1:Number, param2:String = "MM-DD-YYYY", param3:Boolean = true) : String
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Date = new Date(param1);
         var _loc8_:String = param2;
         var _loc9_:Array = ["","January","February","March","April","May","June","July","August","September","October","November","December"];
         var _loc10_:Array = ["","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
         if(param3)
         {
            _loc4_ = String(_loc7_.getUTCDate());
            _loc5_ = String(_loc7_.getUTCMonth() + 1);
            _loc6_ = String(_loc7_.getUTCFullYear());
         }
         else
         {
            _loc4_ = String(_loc7_.getDate());
            _loc5_ = String(_loc7_.getMonth() + 1);
            _loc6_ = String(_loc7_.getFullYear());
         }
         var _loc11_:String = "unset";
         var _loc12_:String = "unset";
         var _loc13_:String = "unset";
         if(param2.indexOf("MM") > -1)
         {
            _loc11_ = "MM";
         }
         else if(param2.indexOf("mm") > -1)
         {
            _loc11_ = "mm";
         }
         else if(param2.indexOf("M") > -1)
         {
            _loc11_ = "M";
         }
         else if(param2.indexOf("m") > -1)
         {
            _loc11_ = "m";
         }
         if(param2.indexOf("DD") > -1)
         {
            _loc12_ = "DD";
         }
         else if(param2.indexOf("dd") > -1)
         {
            _loc12_ = "dd";
         }
         if(param2.indexOf("YYYY") > -1)
         {
            _loc13_ = "YYYY";
         }
         else if(param2.indexOf("YY") > -1)
         {
            _loc13_ = "YY";
         }
         if(_loc11_ == "MM" && _loc5_.length == 1)
         {
            _loc5_ = "0" + _loc5_;
         }
         else if(_loc11_ == "M")
         {
            _loc5_ = _loc9_[Number(_loc5_)];
         }
         else if(_loc11_ == "m")
         {
            _loc5_ = _loc10_[Number(_loc5_)];
         }
         if(_loc12_ == "DD" && _loc4_.length == 1)
         {
            _loc4_ = "0" + _loc4_;
         }
         if(_loc13_ == "YY")
         {
            _loc6_ = _loc6_.substr(2);
         }
         _loc8_ = _loc8_.replace(_loc11_,_loc5_);
         _loc8_ = _loc8_.replace(_loc12_,_loc4_);
         return _loc8_.replace(_loc13_,_loc6_);
      }
   }
}

