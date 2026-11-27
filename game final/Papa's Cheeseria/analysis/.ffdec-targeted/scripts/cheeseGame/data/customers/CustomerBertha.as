package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerBertha extends CustomerDataFile
   {
      
      public function CustomerBertha()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Bertha";
         this.customerClipName = "Bertha";
         this.customerFirstGame = "Papa\'s Hot Doggeria";
         this.thumbColor = "emerald";
         this.isHuge = true;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_SALAMI,FoodData.SAUCE_RANCH,FoodData.TOPPING_BACON,FoodData.SAUCE_RANCH,FoodData.TOPPING_BACON);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc2_.setBread(FoodData.BREAD_PUMPKIN);
         _loc2_.setCheese(FoodData.CHEESE_CHEESEBALL);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_STUFFING,FoodData.SAUCE_GRAVY,FoodData.TOPPING_STUFFING,FoodData.SAUCE_GRAVY,FoodData.TOPPING_STUFFING);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_BACON,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}

