package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerPapaLouie extends CustomerDataFile
   {
      
      public function CustomerPapaLouie()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Papa Louie";
         this.customerClipName = "PapaLouie";
         this.thumbColor = "midblue";
         this.customerFirstGame = "Papa Louie";
         this.flipdeckNumber = 15;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_CIABATTA);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_FRIEDEGG,FoodData.TOPPING_SALAMI,FoodData.SAUCE_HONEYMUSTARD,FoodData.TOPPING_OLIVES);
         _loc1_.setFries(FoodData.FRIES_WAFFLE);
         _loc1_.addFryToppings(FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_APRIL);
         _loc2_.setBread(FoodData.BREAD_CIABATTA);
         _loc2_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_SALAMI,FoodData.TOPPING_PICKLEDEGGS,FoodData.TOPPING_SALAMI,FoodData.SAUCE_HOLLANDAISE,FoodData.TOPPING_OLIVES);
         _loc2_.setFries(FoodData.FRIES_WAFFLE);
         _loc2_.addFryToppings(FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc2_);
      }
   }
}

