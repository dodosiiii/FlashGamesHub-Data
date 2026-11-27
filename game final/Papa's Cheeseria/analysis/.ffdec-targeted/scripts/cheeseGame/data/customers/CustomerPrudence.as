package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerPrudence extends CustomerDataFile
   {
      
      public function CustomerPrudence()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Prudence";
         this.customerClipName = "Prudence";
         this.thumbColor = "bluepurple";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 86;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_FLATBREAD);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_ONIONS,FoodData.TOPPING_PICKLES,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PICKLES);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_FLATBREAD);
         _loc2_.setCheese(FoodData.CHEESE_GRUYERE);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_ONIONS,FoodData.TOPPING_PICKLES,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_PICKLES);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_SEASONING,FoodData.SAUCE_RANCH);
         this.addCustomerOrder(_loc2_);
      }
   }
}

