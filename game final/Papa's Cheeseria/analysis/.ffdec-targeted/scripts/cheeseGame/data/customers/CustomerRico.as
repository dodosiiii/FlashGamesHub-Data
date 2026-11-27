package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerRico extends CustomerDataFile
   {
      
      public function CustomerRico()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Rico";
         this.customerClipName = "Rico";
         this.customerFirstGame = "Papa\'s Taco Mia!";
         this.thumbColor = "yelloworange";
         this.flipdeckNumber = 30;
         this.setupOrder();
         this.isHuge = true;
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PRETZEL);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PEPPERS,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS,FoodData.SAUCE_SOUTHWEST);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JULY);
         _loc2_.setBread(FoodData.BREAD_TEXASTOAST);
         _loc2_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_PEPPERS,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_ONIONS,FoodData.SAUCE_SOUTHWEST);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc2_);
      }
   }
}

