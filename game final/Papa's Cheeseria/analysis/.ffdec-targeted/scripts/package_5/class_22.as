package package_5
{
   import flipline.api.class_17;
   
   public class class_22
   {
      
      private var api:class_17;
      
      public var var_249:Boolean = false;
      
      public var var_285:Boolean = false;
      
      public var var_268:Boolean = false;
      
      public var var_238:String = "";
      
      public var var_247:String = "";
      
      public var var_214:Array;
      
      public function class_22(param1:class_17, param2:Boolean = false)
      {
         this.var_214 = [];
         super();
         this.api = param1;
         this.var_249 = param2;
      }
      
      public function method_264(param1:Boolean = true, param2:String = "", param3:Boolean = true, param4:String = "") : void
      {
         this.var_268 = param1;
         this.var_247 = param2;
         this.var_285 = param3;
         this.var_238 = param4;
      }
      
      public function method_256(param1:String) : void
      {
         this.var_214.push(param1);
      }
   }
}

