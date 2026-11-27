package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerCecilia extends CustomerDataFile
   {
      
      public function CustomerCecilia()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Cecilia";
         this.customerClipName = "Cecilia";
         this.thumbColor = "midred";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS,FoodData.TOPPING_SAUERKRAUT);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc2_.setBread(FoodData.BREAD_WHEAT);
         _loc2_.setCheese(FoodData.CHEESE_GINGERSPICE);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_MUSHROOMS,FoodData.SAUCE_CRANBERRY);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc2_);
      }
   }
}

