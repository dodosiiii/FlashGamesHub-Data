package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerBigPauly extends CustomerDataFile
   {
      
      public function CustomerBigPauly()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Big Pauly";
         this.customerClipName = "BigPauly";
         this.thumbColor = "lightred";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 21;
         this.isHuge = true;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.TOPPING_BACON,FoodData.TOPPING_HAM,FoodData.SAUCE_AWESOME);
         _loc1_.setFries(FoodData.FRIES_CURLY);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_NOVEMBER);
         _loc2_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc2_.setCheese(FoodData.CHEESE_CHEESEBALL);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TURKEY,FoodData.TOPPING_HAM,FoodData.TOPPING_STUFFING,FoodData.SAUCE_GRAVY);
         _loc2_.setFries(FoodData.FRIES_CURLY);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.SAUCE_AWESOME);
         this.addCustomerOrder(_loc2_);
      }
   }
}

