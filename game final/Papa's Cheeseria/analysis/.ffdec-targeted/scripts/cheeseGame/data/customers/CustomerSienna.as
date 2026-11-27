package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerSienna extends CustomerDataFile
   {
      
      public function CustomerSienna()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Sienna";
         this.customerClipName = "Sienna";
         this.thumbColor = "yelloworange";
         this.customerFirstGame = "Papa\'s Pastaria";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_TURKEY,FoodData.SAUCE_RANCH,FoodData.TOPPING_TURKEY);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc2_.setBread(FoodData.BREAD_PUMPKIN);
         _loc2_.setCheese(FoodData.CHEESE_SWISS);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_TURKEY,FoodData.TOPPING_STUFFING,FoodData.SAUCE_GRAVY,FoodData.TOPPING_TURKEY,FoodData.TOPPING_STUFFING);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc2_);
      }
   }
}

