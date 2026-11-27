package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerHugo extends CustomerDataFile
   {
      
      public function CustomerHugo()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Hugo";
         this.customerClipName = "Hugo";
         this.thumbColor = "bluepurple";
         this.flipdeckNumber = 59;
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_WHEAT);
         _loc1_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc1_.setCookType(FoodData.COOK_WELL);
         _loc1_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PICKLES,FoodData.SAUCE_HONEYMUSTARD);
         _loc1_.setFries(FoodData.FRIES_CRINKLE);
         _loc1_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_JANUARY);
         _loc2_.setBread(FoodData.BREAD_CHEDDARSWIRL);
         _loc2_.setCheese(FoodData.CHEESE_CHEDDAR);
         _loc2_.setCookType(FoodData.COOK_WELL);
         _loc2_.addToppings(FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_JALAPENOS,FoodData.TOPPING_PHILLYSTEAK,FoodData.TOPPING_PICKLES,FoodData.SAUCE_HONEYMUSTARD);
         _loc2_.setFries(FoodData.FRIES_CRINKLE);
         _loc2_.addFryToppings(FoodData.SAUCE_AWESOME,FoodData.TOPPING_JALAPENOS);
         this.addCustomerOrder(_loc2_);
      }
   }
}

