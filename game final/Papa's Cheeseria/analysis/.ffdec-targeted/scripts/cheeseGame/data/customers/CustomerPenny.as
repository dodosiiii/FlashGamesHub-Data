package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerPenny extends CustomerDataFile
   {
      
      public function CustomerPenny()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Penny";
         this.customerClipName = "Penny";
         this.thumbColor = "dustyblue";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 46;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_SWISS);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_FRIEDEGG,FoodData.SAUCE_AWESOME);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_APRIL);
         _loc2_.setBread(FoodData.BREAD_CIABATTA);
         _loc2_.setCheese(FoodData.CHEESE_SIRECZ);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.TOPPING_HAM,FoodData.TOPPING_PICKLEDEGGS,FoodData.TOPPING_FRIEDEGG,FoodData.SAUCE_HOLLANDAISE);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_SOURCREAM);
         this.addCustomerOrder(_loc2_);
      }
   }
}

