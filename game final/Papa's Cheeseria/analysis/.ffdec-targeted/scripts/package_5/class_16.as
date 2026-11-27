package package_5
{
   import flipline.api.class_17;
   
   public class class_16
   {
      
      private var api:class_17;
      
      public var label:String;
      
      public var var_236:String;
      
      public var var_330:Boolean;
      
      public var var_317:String;
      
      public var var_303:Boolean;
      
      public var var_286:Boolean;
      
      public var var_272:String;
      
      public var var_316:Boolean = false;
      
      public var var_325:String = "small";
      
      public var var_332:String = "";
      
      public var var_208:String = "";
      
      public var var_289:Boolean = false;
      
      public var var_297:Boolean = false;
      
      public var var_306:String = "small";
      
      public var var_300:String = "";
      
      public var var_210:String = "";
      
      public var var_333:Boolean = false;
      
      public var var_326:Boolean = false;
      
      public var var_311:String = "small";
      
      public var var_310:String = "";
      
      public var var_212:String = "";
      
      public var var_323:Boolean = false;
      
      public var var_239:String = "";
      
      public var var_320:Boolean = false;
      
      public var var_309:String = "";
      
      public var var_307:Boolean = false;
      
      public var var_293:String = "";
      
      public var var_242:Boolean = false;
      
      public var var_279:Boolean = false;
      
      public var var_179:Boolean = false;
      
      public var var_259:Boolean = false;
      
      public var var_185:Array;
      
      public var var_149:class_22 = null;
      
      public function class_16(param1:class_17, param2:String, param3:String, param4:Boolean = false, param5:String = "", param6:Boolean = true, param7:String = "top left", param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false)
      {
         this.var_185 = [];
         super();
         this.api = param1;
         this.label = param2;
         this.var_236 = param3;
         this.var_330 = param4;
         this.var_317 = param5;
         this.var_303 = param6;
         this.var_272 = param7;
         this.var_286 = param8;
         this.var_242 = param9;
         this.var_279 = param10;
         this.var_179 = param11;
         this.var_259 = param12;
      }
      
      public function method_108(param1:Boolean = true, param2:String = "bottom left", param3:String = "http://www.flipline.com", param4:Boolean = false, param5:String = "small") : void
      {
         this.var_316 = param1;
         this.var_332 = param2;
         this.var_208 = param3;
         this.var_325 = param5;
         this.var_289 = param4;
      }
      
      public function method_124(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String) : void
      {
         this.var_297 = param1;
         this.var_300 = param2;
         this.var_210 = param3;
         this.var_333 = param4;
         this.var_306 = param5;
      }
      
      public function method_113(param1:Boolean, param2:String, param3:String, param4:String) : void
      {
         this.var_326 = param1;
         this.var_310 = param2;
         this.var_212 = param3;
         this.var_311 = param4;
      }
      
      public function method_260(param1:Boolean, param2:String) : void
      {
         this.var_323 = param1;
         this.var_239 = param2;
      }
      
      public function method_231(param1:Boolean, param2:String) : void
      {
         this.var_320 = param1;
         this.var_309 = param2;
      }
      
      public function method_247(param1:Boolean, param2:String) : void
      {
         this.var_307 = param1;
         this.var_293 = param2;
      }
      
      public function method_214(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:String, param6:String, param7:String, param8:*, param9:Boolean, param10:Boolean) : void
      {
         var _loc11_:class_21 = new class_21(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         this.var_185.push(_loc11_);
      }
      
      public function method_116(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false, param5:Number = -1, param6:Boolean = false, param7:String = null) : void
      {
         var _loc8_:class_21 = new class_21(param1,"large",false,param3,"button",param2,"",null,param4,false,param5,param6,param7);
         this.var_185.push(_loc8_);
      }
      
      public function method_123(param1:String, param2:String, param3:Boolean = false, param4:String = null) : void
      {
         var _loc5_:class_21 = new class_21(param1,"small",param3,false,"button",param2,"",null,false,true,-1,false,param4);
         this.var_185.push(_loc5_);
      }
      
      public function method_112(param1:String, param2:String, param3:Boolean = false, param4:Number = -1, param5:String = null) : void
      {
         var _loc6_:class_21 = new class_21(param1,"small",false,false,"button",param2,"",null,param3,false,param4,false,param5);
         this.var_185.push(_loc6_);
      }
      
      public function method_182(param1:String, param2:String, param3:Boolean = false, param4:Number = -1, param5:String = null) : void
      {
         var _loc6_:class_21 = new class_21(param1,"small",false,false,"link","",param2,null,param3,false,param4,false,param5);
         this.var_185.push(_loc6_);
      }
      
      public function method_284(param1:String, param2:*, param3:Boolean = false, param4:String = null) : void
      {
         var _loc5_:class_21 = new class_21(param1,"small",false,false,"custom","","",param2,param3,false,-1,false,param4);
         this.var_185.push(_loc5_);
      }
      
      public function method_189(param1:Boolean = false) : void
      {
         this.var_149 = new class_22(this.api,param1);
      }
      
      public function method_200(param1:Boolean = true, param2:String = "", param3:Boolean = true, param4:String = "") : void
      {
         if(this.var_149)
         {
            this.var_149.method_264(param1,param2,param3,param4);
         }
      }
      
      public function method_117(param1:String = "") : void
      {
         if(this.var_149)
         {
            this.var_149.method_256(param1);
         }
      }
   }
}

