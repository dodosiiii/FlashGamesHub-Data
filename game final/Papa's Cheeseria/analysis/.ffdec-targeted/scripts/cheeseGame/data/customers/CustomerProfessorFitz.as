package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerProfessorFitz extends CustomerDataFile
   {
      
      public function CustomerProfessorFitz()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Professor Fitz";
         this.customerClipName = "ProfessorFitz";
         this.customerFirstGame = "Papa\'s Wingeria";
         this.thumbColor = "deepred";
         this.flipdeckNumber = 96;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_THREECHEESE);
         _loc1_.setCheese(FoodData.CHEESE_HAVARTI);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_PEPPERS,FoodData.SAUCE_RANCH);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_THREECHEESE);
         _loc2_.setCheese(FoodData.CHEESE_GRUYERE);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_LETTUCE,FoodData.TOPPING_CHICKEN,FoodData.TOPPING_PEPPERS,FoodData.SAUCE_PARMESAN);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHEDDAR);
         this.addCustomerOrder(_loc2_);
      }
   }
}

