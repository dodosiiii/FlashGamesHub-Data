package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerMayorMallow extends CustomerDataFile
   {
      
      public function CustomerMayorMallow()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Mayor Mallow";
         this.customerClipName = "MayorMallow";
         this.customerFirstGame = "Papa\'s Cupcakeria";
         this.thumbColor = "seafoam";
         this.flipdeckNumber = 133;
         this.isHuge = true;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_MULTIGRAIN);
         _loc1_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc1_.setCookType(FoodData.COOK_LIGHT);
         _loc1_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_ONIONS,FoodData.TOPPING_PHILLYSTEAK,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_SAUERKRAUT);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MARCH);
         _loc2_.setBread(FoodData.BREAD_BARMBRACK);
         _loc2_.setCheese(FoodData.CHEESE_GORGONZOLA);
         _loc2_.setCookType(FoodData.COOK_LIGHT);
         _loc2_.addToppings(FoodData.TOPPING_BEEFHASH,FoodData.TOPPING_ONIONS,FoodData.TOPPING_PHILLYSTEAK,FoodData.SAUCE_BUFFALO,FoodData.TOPPING_SAUERKRAUT);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.SAUCE_KETCHUP,FoodData.FRYSAUCE_POUTINE);
         this.addCustomerOrder(_loc2_);
      }
   }
}

