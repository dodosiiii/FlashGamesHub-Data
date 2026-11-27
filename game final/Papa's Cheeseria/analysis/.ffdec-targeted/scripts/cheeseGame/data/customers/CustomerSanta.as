package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerSanta extends CustomerDataFile
   {
      
      public function CustomerSanta()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Santa";
         this.customerClipName = "Santa";
         this.customerFirstGame = "Papa\'s Cupcakeria";
         this.thumbColor = "midred";
         this.flipdeckNumber = 94;
         this.notInPool = true;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHITE);
         _loc1_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.SAUCE_AWESOME);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_DECEMBER);
         _loc2_.setBread(FoodData.BREAD_FRUITCAKE);
         _loc2_.setCheese(FoodData.CHEESE_AGEDGOUDA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_GOOSE,FoodData.TOPPING_BACON,FoodData.TOPPING_GOOSE,FoodData.SAUCE_AWESOME);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc2_);
      }
   }
}

