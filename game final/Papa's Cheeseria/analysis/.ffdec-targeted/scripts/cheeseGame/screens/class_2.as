package cheeseGame.screens
{
   import flash.display.*;
   import flash.events.*;
   import package_2.*;
   
   public dynamic class class_2
   {
      
      public var container:MovieClip;
      
      public var clip:MovieClip;
      
      public var maxSpeed:Number = 50;
      
      public var var_71:Number = 26;
      
      public var var_43:Number = 544;
      
      public var var_125:Boolean = false;
      
      public var var_127:Boolean = true;
      
      public var var_126:Boolean = true;
      
      public var var_65:Boolean = false;
      
      public var var_28:MovieClip;
      
      public var var_121:Boolean = false;
      
      public var completeFunction:Function = null;
      
      public function class_2(param1:MovieClip, param2:Function)
      {
         super();
         var _loc3_:class_2 = this;
         _loc3_.container = param1;
         _loc3_.completeFunction = param2;
         _loc3_.setupScreen();
      }
      
      private function method_41() : LoaderInfo
      {
         return this.container.loaderInfo;
      }
      
      public function method_94(param1:Event = null) : void
      {
      }
      
      public function method_88(param1:Event = null) : void
      {
      }
      
      public function setupScreen(param1:Event = null) : void
      {
         var _loc2_:class_2 = this;
         _loc2_.clip = new loadingMC();
         _loc2_.container.addChild(_loc2_.clip);
         _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.updateScreen);
         _loc2_.clip.loader_bar.percent_txt.text = "0%";
         _loc2_.var_28 = new MovieClip();
         _loc2_.var_28.x = 252;
         _loc2_.var_28.y = 379;
         _loc2_.clip.addChild(_loc2_.var_28);
         _loc2_.var_28.visible = false;
         _loc2_.var_28.addEventListener("clickPlayBtn",_loc2_.method_34);
         if(class_3.method_54())
         {
            _loc2_.var_65 = this.var_127;
         }
         else if(class_3.method_60())
         {
            _loc2_.var_65 = this.var_125;
         }
         else
         {
            _loc2_.var_65 = this.var_126;
         }
      }
      
      public function method_44() : void
      {
         var _loc1_:class_2 = this;
         if(!_loc1_.var_121)
         {
            _loc1_.var_121 = true;
            if(_loc1_.var_65)
            {
               if(_loc1_.completeFunction != null)
               {
                  _loc1_.completeFunction();
               }
            }
            else
            {
               _loc1_.var_28.visible = true;
            }
         }
      }
      
      public function method_34(param1:Event = null) : void
      {
         var _loc2_:class_2 = this;
         if(_loc2_.completeFunction != null)
         {
            _loc2_.completeFunction();
         }
      }
      
      public function method_62(param1:Event = null) : void
      {
         var _loc2_:class_2 = this;
         _loc2_.setupScreen();
      }
      
      public function updateScreen(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:class_2 = this;
         if(_loc5_.clip.currentFrame == 28)
         {
            _loc2_ = _loc5_.method_41().bytesLoaded / _loc5_.method_41().bytesTotal;
            _loc3_ = (_loc5_.clip.loader_bar.x - _loc5_.var_71) / _loc5_.var_43;
            _loc4_ = 0;
            if(_loc2_ * _loc5_.var_43 - _loc3_ * _loc5_.var_43 <= _loc5_.maxSpeed)
            {
               _loc5_.clip.loader_bar.x = _loc5_.var_71 + _loc2_ * _loc5_.var_43;
               _loc4_ = _loc2_;
            }
            else
            {
               _loc5_.clip.loader_bar.x += _loc5_.maxSpeed;
               _loc4_ = (_loc5_.clip.loader_bar.x - _loc5_.var_71) / _loc5_.var_43;
            }
            _loc5_.clip.loader_bar.percent_txt.text = String(Math.round(_loc4_ * 100)) + "%";
            if(_loc5_.clip.loader_bar.x >= _loc5_.var_71 + _loc5_.var_43)
            {
               _loc5_.clip.loader_bar.x = 2000;
               _loc5_.clip.gotoAndPlay("animout");
            }
         }
         else if(_loc5_.clip.currentFrame == _loc5_.clip.totalFrames)
         {
            _loc5_.method_44();
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:class_2 = this;
         _loc1_.var_28.removeEventListener("clickPlayBtn",_loc1_.method_34);
         _loc1_.var_28 = null;
         _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateScreen);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
   }
}

