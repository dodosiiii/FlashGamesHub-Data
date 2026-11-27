package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerNick extends CustomerDataFile
   {
      
      public function CustomerNick()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Nick";
         this.customerClipName = "Nick";
         this.customerFirstGame = "Papa\'s Taco Mia!";
         this.thumbColor = "lightred";
         this.flipdeckNumber = 29;
         this.setupOrder();
         this.isHuge = true;
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc1_.setCheese(FoodData.CHEESE_ASIAGO);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_BACON,FoodData.TOPPING_LETTUCE,FoodData.TOPPING_ONIONS,FoodData.SAUCE_BUFFALO);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_PUMPERNICKEL);
         _loc2_.setCheese(FoodData.CHEESE_GRUYERE);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_MACNCHEESE,FoodData.TOPPING_PULLEDPORK,FoodData.TOPPING_BACON,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_MACNCHEESE);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}

