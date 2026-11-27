package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerOlga extends CustomerDataFile
   {
      
      public function CustomerOlga()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Olga";
         this.customerClipName = "Olga";
         this.thumbColor = "pink";
         this.flipdeckNumber = 38;
         this.setupOrder();
         this.isHuge = true;
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.SAUCE_KETCHUP,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_KETCHUP);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_AUGUST);
         _loc2_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc2_.setCheese(FoodData.CHEESE_RICOTTA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_MARINARA,FoodData.TOPPING_PEPPERS,FoodData.TOPPING_CHICKEN,FoodData.SAUCE_MARINARA);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc2_);
      }
   }
}

