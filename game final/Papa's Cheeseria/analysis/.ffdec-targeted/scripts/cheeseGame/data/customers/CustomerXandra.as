package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerXandra extends CustomerDataFile
   {
      
      public function CustomerXandra()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Xandra";
         this.customerClipName = "Xandra";
         this.customerFirstGame = "Papa\'s Taco Mia!";
         this.thumbColor = "pink";
         this.holidayOutfit = GameData.MONTH_JANUARY;
         this.holidayHandExtra = "xwand";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO);
         _loc1_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_CHEDDARSWIRL);
         _loc2_.setCheese(FoodData.CHEESE_AMERICAN);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_MACNCHEESE,FoodData.TOPPING_BACON,FoodData.TOPPING_MACNCHEESE,FoodData.TOPPING_BACON,FoodData.TOPPING_MACNCHEESE);
         _loc2_.setFries(FoodData.FRIES_SWEETPOTATO);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_NACHO,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc2_);
      }
   }
}

