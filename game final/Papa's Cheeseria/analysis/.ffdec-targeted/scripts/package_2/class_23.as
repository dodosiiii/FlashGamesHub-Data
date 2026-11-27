package package_2
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import flipline.api.class_17;
   import package_3.*;
   
   public class class_23
   {
      
      private var api:class_17;
      
      private var var_182:FileReference = null;
      
      private var var_154:MovieClip = null;
      
      private var saveData:Object;
      
      private var var_178:class_18;
      
      private var var_171:class_18;
      
      private var var_274:Function = null;
      
      private var var_302:String = "backup";
      
      private var var_298:String = "";
      
      private var var_173:FileReference = null;
      
      private var var_150:MovieClip = null;
      
      private var var_180:class_18;
      
      private var var_168:class_18;
      
      private var var_260:Function = null;
      
      private var var_288:Number = 0;
      
      private var var_252:String = "";
      
      private var var_314:String = "/";
      
      private var var_164:MovieClip = null;
      
      private var var_181:class_18;
      
      public function class_23(param1:class_17)
      {
         super();
         this.api = param1;
      }
      
      public function method_133(param1:Object, param2:String, param3:String, param4:Function) : void
      {
         var _loc5_:class_23 = null;
         _loc5_ = this;
         _loc5_.saveData = param1;
         _loc5_.var_274 = param4;
         _loc5_.var_298 = param2;
         _loc5_.var_302 = param3;
         if(_loc5_.var_154 != null)
         {
            if(_loc5_.var_154.parent)
            {
               _loc5_.var_154.parent.removeChild(_loc5_.var_154);
            }
            _loc5_.var_154 = null;
         }
         _loc5_.var_154 = new saveBackupMC();
         _loc5_.var_154.gotoAndStop(1);
         _loc5_.api.container.addChild(_loc5_.var_154);
         _loc5_.var_178 = new class_18(null,"Save...","large","button","clickSaveButton",null,false,false,false,null,false,140);
         _loc5_.var_178.x = (640 - _loc5_.var_178.width) / 2;
         _loc5_.var_178.y = 242;
         _loc5_.var_154.addChild(_loc5_.var_178);
         _loc5_.var_178.addEventListener("clickSaveButton",_loc5_.method_163);
         _loc5_.var_171 = new class_18(null,"CLOSE","small","button","clickSaveCloseButton",null,false,false,false,null,false,140);
         _loc5_.var_171.x = (640 - _loc5_.var_171.width) / 2;
         _loc5_.var_171.y = 291;
         _loc5_.var_154.addChild(_loc5_.var_171);
         _loc5_.var_171.addEventListener("clickSaveCloseButton",_loc5_.method_180);
      }
      
      private function method_180(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.method_157(param1);
      }
      
      private function method_163(param1:Event) : void
      {
         var byteArray:ByteArray;
         var ob:class_23 = null;
         ob = null;
         var e:Event = param1;
         ob = this;
         ob.var_178.visible = false;
         ob.var_171.visible = false;
         ob.var_154.gotoAndStop("saving");
         ob.saveData.gameSKU = ob.var_298;
         byteArray = new ByteArray();
         byteArray.writeObject(ob.saveData);
         byteArray.compress();
         ob.var_182 = new FileReference();
         ob.var_182.addEventListener(Event.COMPLETE,ob.method_168);
         ob.var_182.addEventListener(Event.CANCEL,ob.method_157);
         ob.var_182.addEventListener(IOErrorEvent.IO_ERROR,ob.method_188);
         try
         {
            ob.var_182.save(byteArray,ob.var_302 + ".papa");
         }
         catch(err:Error)
         {
            ob.method_245(err);
         }
      }
      
      private function method_238() : void
      {
         var _loc1_:class_23 = this;
         if(_loc1_.var_182 != null)
         {
            _loc1_.var_182.removeEventListener(Event.COMPLETE,_loc1_.method_168);
            _loc1_.var_182.removeEventListener(Event.CANCEL,_loc1_.method_157);
            _loc1_.var_182.removeEventListener(IOErrorEvent.IO_ERROR,_loc1_.method_188);
            _loc1_.var_182 = null;
         }
         if(_loc1_.var_178)
         {
            _loc1_.var_178.removeEventListener("clickSaveButton",_loc1_.method_163);
            if(_loc1_.var_154)
            {
               _loc1_.var_154.removeChild(_loc1_.var_178);
            }
            _loc1_.var_178.destroy();
            _loc1_.var_178 = null;
         }
         if(_loc1_.var_171)
         {
            _loc1_.var_171.removeEventListener("clickSaveCloseButton",_loc1_.method_180);
            if(_loc1_.var_154)
            {
               _loc1_.var_154.removeChild(_loc1_.var_171);
            }
            _loc1_.var_171.destroy();
            _loc1_.var_171 = null;
         }
         if(_loc1_.var_154)
         {
            if(_loc1_.var_154.parent)
            {
               _loc1_.var_154.parent.removeChild(_loc1_.var_154);
            }
            _loc1_.var_154 = null;
         }
      }
      
      private function method_168(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.var_154.gotoAndStop("success");
         _loc2_.var_171.visible = true;
      }
      
      private function method_157(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.method_238();
         if(_loc2_.var_274 != null)
         {
            _loc2_.var_274();
         }
      }
      
      private function method_188(param1:IOErrorEvent) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.var_154.gotoAndStop("failure");
         trace("IO Error Saving: " + param1.text);
         _loc2_.var_171.visible = true;
      }
      
      private function method_245(param1:Error) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.var_154.gotoAndStop("failure");
         trace("Error Saving: " + param1.message);
         _loc2_.var_171.visible = true;
      }
      
      public function method_142(param1:Number, param2:String, param3:String, param4:Function = null) : void
      {
         var _loc5_:class_23 = null;
         _loc5_ = this;
         _loc5_.var_288 = param1;
         _loc5_.var_252 = param2;
         _loc5_.var_314 = param3;
         _loc5_.var_260 = param4;
         if(_loc5_.var_150 != null)
         {
            if(_loc5_.var_150.parent)
            {
               _loc5_.var_150.parent.removeChild(_loc5_.var_150);
            }
            _loc5_.var_150 = null;
         }
         _loc5_.var_150 = new loadBackupMC();
         _loc5_.var_150.gotoAndStop(1);
         _loc5_.api.container.addChild(_loc5_.var_150);
         _loc5_.var_180 = new class_18(null,"Load...","large","button","clickLoadButton",null,false,false,false,null,false,140);
         _loc5_.var_180.x = (640 - _loc5_.var_180.width) / 2;
         _loc5_.var_180.y = 242;
         _loc5_.var_150.addChild(_loc5_.var_180);
         _loc5_.var_180.addEventListener("clickLoadButton",_loc5_.method_178);
         _loc5_.var_168 = new class_18(null,"CLOSE","small","button","clickLoadCloseButton",null,false,false,false,null,false,140);
         _loc5_.var_168.x = (640 - _loc5_.var_168.width) / 2;
         _loc5_.var_168.y = 291;
         _loc5_.var_150.addChild(_loc5_.var_168);
         _loc5_.var_168.addEventListener("clickLoadCloseButton",_loc5_.method_160);
      }
      
      private function method_160(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.method_150(param1);
      }
      
      private function method_178(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.var_180.visible = false;
         _loc2_.var_168.visible = false;
         _loc2_.var_150.gotoAndStop("loading");
         _loc2_.var_173 = new FileReference();
         _loc2_.var_173.addEventListener(Event.SELECT,_loc2_.method_192);
         _loc2_.var_173.addEventListener(Event.CANCEL,_loc2_.method_150);
         var _loc3_:FileFilter = new FileFilter("Papa Backup Files","*.papa");
         _loc2_.var_173.browse([_loc3_]);
      }
      
      private function method_210() : void
      {
         var ob:class_23 = null;
         ob = null;
         var data:ByteArray = null;
         var sourceObject:Object = null;
         var so:SharedObject = null;
         var i:String = null;
         ob = this;
         try
         {
            data = ob.var_173.data;
            data.uncompress();
            sourceObject = data.readObject();
            if(sourceObject.hasOwnProperty("gameSKU") && sourceObject.gameSKU == ob.var_252)
            {
               so = SharedObject.getLocal(ob.var_252 + ob.var_288,ob.var_314);
               for(i in sourceObject)
               {
                  so.data[i] = sourceObject[i];
               }
               so.flush(15360);
               sourceObject = null;
               ob.var_150.gotoAndStop("success");
               ob.var_168.visible = true;
            }
            else
            {
               sourceObject = null;
               ob.var_150.gotoAndStop("invalid");
               ob.var_168.visible = true;
            }
         }
         catch(err:Error)
         {
            trace("Error Restoring Data to a Save Slot!!");
            ob.method_220(err);
         }
      }
      
      private function method_192(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.var_173.addEventListener(Event.COMPLETE,_loc2_.method_166);
         _loc2_.var_173.addEventListener(IOErrorEvent.IO_ERROR,_loc2_.method_172);
         _loc2_.var_173.load();
      }
      
      private function method_263() : void
      {
         var _loc1_:class_23 = this;
         if(_loc1_.var_173 != null)
         {
            _loc1_.var_173.removeEventListener(Event.COMPLETE,_loc1_.method_166);
            _loc1_.var_173.removeEventListener(Event.SELECT,_loc1_.method_192);
            _loc1_.var_173.removeEventListener(Event.CANCEL,_loc1_.method_150);
            _loc1_.var_173.removeEventListener(IOErrorEvent.IO_ERROR,_loc1_.method_172);
            _loc1_.var_173 = null;
         }
         if(_loc1_.var_180)
         {
            _loc1_.var_180.removeEventListener("clickLoadButton",_loc1_.method_178);
            if(_loc1_.var_150)
            {
               _loc1_.var_150.removeChild(_loc1_.var_180);
            }
            _loc1_.var_180.destroy();
            _loc1_.var_180 = null;
         }
         if(_loc1_.var_168)
         {
            _loc1_.var_168.removeEventListener("clickLoadCloseButton",_loc1_.method_160);
            if(_loc1_.var_150)
            {
               _loc1_.var_150.removeChild(_loc1_.var_168);
            }
            _loc1_.var_168.destroy();
            _loc1_.var_168 = null;
         }
         if(_loc1_.var_150)
         {
            if(_loc1_.var_150.parent)
            {
               _loc1_.var_150.parent.removeChild(_loc1_.var_150);
            }
            _loc1_.var_150 = null;
         }
      }
      
      private function method_166(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.method_210();
      }
      
      private function method_150(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.method_263();
         if(_loc2_.var_260 != null)
         {
            _loc2_.var_260();
         }
      }
      
      private function method_172(param1:IOErrorEvent) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.var_150.gotoAndStop("failure");
         trace("IO Error Loading: " + param1.text);
         _loc2_.var_168.visible = true;
      }
      
      private function method_220(param1:Error) : void
      {
         var _loc2_:class_23 = this;
         _loc2_.var_150.gotoAndStop("failure");
         trace("Error Loading: " + param1.message);
         _loc2_.var_168.visible = true;
      }
      
      public function method_255(param1:Boolean = true) : void
      {
         var _loc2_:class_23 = this;
         if(_loc2_.var_164 != null)
         {
            if(_loc2_.var_164.parent)
            {
               _loc2_.var_164.parent.removeChild(_loc2_.var_164);
            }
            _loc2_.var_164 = null;
         }
         if(param1)
         {
            _loc2_.var_164 = new helpBackupMC();
         }
         else
         {
            _loc2_.var_164 = new helpNoBackupMC();
         }
         _loc2_.var_164.gotoAndStop(1);
         _loc2_.api.container.addChild(_loc2_.var_164);
         _loc2_.var_181 = new class_18(null,"OK","large","button","clickHelpCloseButton",null,false,false,false,null,false,140);
         _loc2_.var_181.x = (640 - _loc2_.var_181.width) / 2;
         _loc2_.var_181.y = 267;
         _loc2_.var_164.addChild(_loc2_.var_181);
         _loc2_.var_181.addEventListener("clickHelpCloseButton",_loc2_.method_169);
      }
      
      private function method_169(param1:Event) : void
      {
         var _loc2_:class_23 = this;
         if(_loc2_.var_181)
         {
            _loc2_.var_181.removeEventListener("clickHelpCloseButton",_loc2_.method_169);
            if(_loc2_.var_164)
            {
               _loc2_.var_164.removeChild(_loc2_.var_181);
            }
            _loc2_.var_181.destroy();
            _loc2_.var_181 = null;
         }
         if(_loc2_.var_164)
         {
            if(_loc2_.var_164.parent)
            {
               _loc2_.var_164.parent.removeChild(_loc2_.var_164);
            }
            _loc2_.var_164 = null;
         }
      }
   }
}

