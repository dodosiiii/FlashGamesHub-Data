package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerJojo extends CustomerDataFile
   {
      
      public function CustomerJojo()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Jojo";
         this.customerClipName = "Jojo";
         this.isCloser = true;
         this.customerFirstGame = "Papa\'s Taco Mia!";
         this.thumbColor = "emerald";
         this.flipdeckNumber = 4;
         this.holidayOutfit = GameData.MONTH_OCTOBER;
         this.setupOrder();
      }
   }
}

