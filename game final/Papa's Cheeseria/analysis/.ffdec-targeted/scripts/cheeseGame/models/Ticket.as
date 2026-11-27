package cheeseGame.models
{
   import cheeseGame.data.*;
   import cheeseGame.screens.FryScreen;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import package_2.*;
   import package_4.class_5;
   
   public class Ticket
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var order:Array;
      
      public var orderData:CustomerOrder;
      
      public var customerType:Number;
      
      public var ticketNumber:Number = 1;
      
      public var targetX:Number = 0;
      
      public var targetY:Number = 0;
      
      public var targetScale:Number = 0;
      
      public var isDragging:Boolean = false;
      
      public var isMoving:Boolean = false;
      
      public var isDrawingOrder:Boolean = false;
      
      public var isOnTray:Boolean = false;
      
      public var hangerX:Number = 558;
      
      public var hangerY:Number = 58;
      
      public var hangerScale:Number = 1;
      
      public var lineStartX:Number = 56;
      
      public var lineEndX:Number = 433;
      
      public var lineY:Number = 20;
      
      public var lineScale:Number = 0.25;
      
      public var trayX:Number = 26;
      
      public var trayY:Number = 13;
      
      public var trayScale:Number = 0.4;
      
      public var minGrabScale:Number = 0.25;
      
      public var maxGrabScale:Number = 1;
      
      public var minGrabY:Number = 15;
      
      public var maxGrabY:Number = 180;
      
      public var maxGrabBoundsY:Number = 320;
      
      public var minGrabX:Number = 22;
      
      public var maxGrabX:Number = 544;
      
      public var minGrabZoomX:Number = 458;
      
      public var tweenSpeed:Number = 2;
      
      public var startingY:Number = -242;
      
      public var trayBoundsLeftX:Number = 460;
      
      public var trayBoundsRightX:Number = 640;
      
      public var trayBoundsTopY:Number = 270;
      
      private var panelHolder:MovieClip = null;
      
      private var panelParts:Vector.<MovieClip>;
      
      private var panelSubParts:Vector.<MovieClip>;
      
      private var panelSpecialBitmap:Bitmap = null;
      
      public var bmp:BitmapData;
      
      public var bitmap:Bitmap;
      
      public function Ticket(param1:class_5, param2:Number, param3:Number)
      {
         var _loc4_:Ticket = null;
         super();
         _loc4_ = this;
         _loc4_.gameObj = param1;
         _loc4_.customerType = param2;
         _loc4_.ticketNumber = param3;
         _loc4_.setupTicket();
      }
      
      public function setupTicket() : void
      {
         var _loc1_:Ticket = this;
         _loc1_.clip = new ticketMC();
         var _loc2_:String = String(_loc1_.ticketNumber);
         if(_loc2_.length < 2)
         {
            _loc2_ = "0" + _loc2_;
         }
         _loc1_.clip.number_txt.text = _loc2_;
         _loc1_.orderData = _loc1_.gameObj.var_130.getCustomerOrderData(_loc1_.customerType);
         _loc1_.order = _loc1_.orderData.getOrderAsArray();
         _loc1_.container = _loc1_.gameObj.hud.clip.ticket_holder;
         _loc1_.container.addChild(_loc1_.clip);
         _loc1_.clip.scaleX = _loc1_.hangerScale;
         _loc1_.clip.scaleY = _loc1_.hangerScale;
         _loc1_.clip.x = _loc1_.hangerX;
         _loc1_.clip.y = _loc1_.startingY;
         _loc1_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickTicket);
         _loc1_.clip.buttonMode = true;
         _loc1_.clip.useHandCursor = true;
         _loc1_.clip.mouseChildren = false;
         _loc1_.isDrawingOrder = true;
         _loc1_.createOrderPanels();
         _loc1_.moveToHanger();
      }
      
      public function createOrderPanels() : void
      {
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:Ticket = this;
         _loc7_.panelHolder = new MovieClip();
         _loc7_.panelParts = new Vector.<MovieClip>();
         if(_loc7_.orderData.isSpecial)
         {
            _loc7_.panelSpecialBitmap = new Bitmap(_loc7_.gameObj.var_134.specialBMP,"auto",true);
            _loc7_.panelSpecialBitmap.scaleX = 0.8;
            _loc7_.panelSpecialBitmap.scaleY = 0.8;
            _loc2_ = new MovieClip();
            _loc2_.addChild(_loc7_.panelSpecialBitmap);
            _loc2_.x = -60;
            _loc2_.y = 48;
            _loc7_.panelParts.push(_loc2_);
            _loc7_.panelHolder.addChild(_loc2_);
            _loc2_.visible = false;
         }
         else
         {
            _loc3_ = new ticket_panel_bread();
            _loc3_.gotoAndStop(_loc7_.orderData.bread);
            _loc3_.x = -31;
            _loc3_.y = 211;
            _loc7_.panelParts.push(_loc3_);
            _loc7_.panelHolder.addChild(_loc3_);
            _loc3_.visible = false;
            _loc4_ = new ticket_panel_cheese();
            _loc4_.gotoAndStop(_loc7_.orderData.cheese);
            _loc4_.x = 40;
            _loc4_.y = 211;
            _loc7_.panelParts.push(_loc4_);
            _loc7_.panelHolder.addChild(_loc4_);
            _loc4_.visible = false;
         }
         _loc8_ = new ticket_panel_cook();
         _loc8_.gotoAndStop(_loc7_.orderData.cookType);
         _loc8_.x = 2;
         _loc8_.y = 232;
         _loc7_.panelParts.push(_loc8_);
         _loc7_.panelHolder.addChild(_loc8_);
         _loc8_.visible = false;
         if(!_loc7_.orderData.isSpecial)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc7_.orderData.toppings.length)
            {
               _loc5_ = null;
               if(FoodData.isSliceTopping(_loc7_.orderData.toppings[_loc1_]))
               {
                  _loc5_ = new ticket_panel_slicetopping();
               }
               else if(FoodData.isSauce(_loc7_.orderData.toppings[_loc1_]))
               {
                  _loc5_ = new ticket_panel_sauce();
               }
               else
               {
                  _loc5_ = new ticket_panel_clump();
               }
               _loc5_.gotoAndStop(_loc7_.orderData.toppings[_loc1_]);
               _loc5_.x = 0;
               _loc5_.y = 172 - 32 * _loc1_;
               _loc7_.panelParts.push(_loc5_);
               _loc7_.panelHolder.addChild(_loc5_);
               _loc5_.visible = false;
               _loc1_++;
            }
         }
         _loc9_ = new ticket_panel_fry();
         _loc9_.gotoAndStop(_loc7_.orderData.fries);
         _loc9_.x = -44;
         _loc9_.y = 12;
         _loc7_.panelParts.push(_loc9_);
         _loc7_.panelHolder.addChild(_loc9_);
         _loc9_.visible = false;
         _loc1_ = 0;
         while(_loc1_ < _loc7_.orderData.frytoppings.length)
         {
            _loc6_ = new ticket_panel_frytopping();
            _loc6_.gotoAndStop(_loc7_.orderData.frytoppings[_loc1_]);
            _loc6_.x = 3 + 46 * _loc1_;
            _loc6_.y = 10;
            _loc7_.panelParts.push(_loc6_);
            _loc7_.panelHolder.addChild(_loc6_);
            _loc6_.visible = false;
            _loc1_++;
         }
         _loc7_.clip.addChild(_loc7_.panelHolder);
      }
      
      public function moveToHanger() : void
      {
         var _loc1_:Ticket = this;
         _loc1_.targetX = _loc1_.hangerX;
         _loc1_.targetY = _loc1_.hangerY;
         _loc1_.targetScale = _loc1_.hangerScale;
         _loc1_.isMoving = true;
         if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateTicketPosition);
         }
         if(_loc1_.gameObj.hud.currentStation == "build" && _loc1_.orderData.isSpecial && !_loc1_.gameObj.var_128.hasTrained("cheatsheet"))
         {
            _loc1_.gameObj.hud.showContextTraining("cheatsheet");
         }
      }
      
      public function moveToLine(param1:Number = -1) : void
      {
         var _loc2_:Ticket = this;
         if(param1 == -1)
         {
            _loc2_.targetX = _loc2_.lineEndX - Math.floor(Math.random() * 30);
         }
         else if(param1 > _loc2_.lineEndX)
         {
            _loc2_.targetX = _loc2_.lineEndX;
         }
         else if(param1 < _loc2_.lineStartX)
         {
            _loc2_.targetX = _loc2_.lineStartX;
         }
         else
         {
            _loc2_.targetX = param1;
         }
         _loc2_.targetY = _loc2_.lineY;
         _loc2_.targetScale = _loc2_.lineScale;
         _loc2_.isMoving = true;
         if(!_loc2_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.updateTicketPosition);
         }
      }
      
      public function moveToTray() : void
      {
         var _loc1_:Ticket = this;
         if(_loc1_.gameObj.var_131.currentOrder != null && _loc1_.gameObj.var_131.currentOrder.ticketHolderClip != null)
         {
            _loc1_.container = _loc1_.gameObj.var_131.currentOrder.ticketHolderClip;
            _loc1_.container.addChild(_loc1_.clip);
            _loc1_.clip.x -= _loc1_.gameObj.var_131.currentOrder.clip.x + _loc1_.gameObj.var_131.currentOrder.ticketHolderClip.x;
            _loc1_.clip.y -= _loc1_.gameObj.var_131.currentOrder.clip.y + _loc1_.gameObj.var_131.currentOrder.ticketHolderClip.y;
            _loc1_.targetX = _loc1_.trayX;
            _loc1_.targetY = _loc1_.trayY;
            _loc1_.targetScale = _loc1_.trayScale / _loc1_.gameObj.var_131.currentOrder.clip.scaleX;
            _loc1_.isMoving = true;
            _loc1_.isOnTray = true;
            _loc1_.gameObj.var_131.clip.trash_btn.visible = false;
            _loc1_.gameObj.hud.disableStationButtons();
            if(!_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
            {
               _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateTicketPosition);
            }
            _loc1_.gameObj.method_104(24);
         }
      }
      
      public function clickTicket(param1:MouseEvent) : void
      {
         var _loc2_:Ticket = this;
         if(!_loc2_.gameObj.var_169 && !_loc2_.isDragging && !_loc2_.isMoving && !_loc2_.isDrawingOrder && !_loc2_.isOnTray && _loc2_.canClickInTraining(param1))
         {
            if(_loc2_.gameObj.var_147.hangerTicket == _loc2_)
            {
               _loc2_.gameObj.var_147.hangerTicket = null;
            }
            _loc2_.isDragging = true;
            _loc2_.isMoving = false;
            _loc2_.clip.startDrag(true,new Rectangle(_loc2_.minGrabX,_loc2_.minGrabY,_loc2_.maxGrabX,_loc2_.maxGrabBoundsY));
            if(!_loc2_.clip.hasEventListener(Event.ENTER_FRAME))
            {
               _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.updateTicketPosition);
            }
            _loc2_.container.setChildIndex(_loc2_.clip,_loc2_.container.numChildren - 1);
            _loc2_.gameObj.addEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseTicket);
            _loc2_.gameObj.var_129.playSound("grabticket.wav");
            if(_loc2_.gameObj.hud.whichContextTraining == "ticket")
            {
               _loc2_.gameObj.hud.removeContextTraining();
            }
         }
      }
      
      public function releaseTicket(param1:MouseEvent = null) : void
      {
         var _loc2_:Ticket = this;
         var _loc3_:FryScreen = _loc2_.gameObj.var_131;
         _loc2_.isDragging = false;
         _loc2_.isMoving = false;
         _loc2_.clip.stopDrag();
         _loc2_.gameObj.var_129.playSound("dropticket.wav");
         try
         {
            _loc2_.gameObj.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.releaseTicket);
         }
         catch(err:Error)
         {
         }
         if(_loc2_.clip.x > _loc2_.hangerX - 90 && _loc2_.clip.x < _loc2_.hangerX + 70 && _loc2_.clip.y < _loc2_.hangerY + 227)
         {
            if(!_loc2_.gameObj.var_147.hangerTicket || _loc2_.gameObj.var_147.hangerTicket.isDrawingOrder == false)
            {
               if(_loc2_.gameObj.var_147.hangerTicket)
               {
                  _loc2_.gameObj.var_147.hangerTicket.moveToLine();
               }
               _loc2_.gameObj.var_147.hangerTicket = _loc2_;
               _loc2_.moveToHanger();
            }
            else
            {
               _loc2_.moveToLine();
            }
         }
         else if(Boolean(_loc2_.gameObj.hud.currentStation == "fry" && _loc2_.gameObj.var_131.currentOrder != null && _loc2_.gameObj.var_131.currentOrder.ticketHolderClip && _loc2_.gameObj.var_131.currentOrder.attachedTicket == null && !_loc2_.gameObj.var_131.currentOrder.isLeavingFry && _loc2_.clip.x >= _loc2_.trayBoundsLeftX) && Boolean(_loc2_.clip.x <= _loc2_.trayBoundsRightX) && _loc2_.clip.y >= _loc2_.trayBoundsTopY)
         {
            _loc2_.moveToTray();
         }
         else
         {
            _loc2_.moveToLine(_loc2_.clip.x);
            if(_loc2_.gameObj.var_147.hangerTicket == _loc2_)
            {
               _loc2_.gameObj.var_147.hangerTicket = null;
            }
         }
      }
      
      public function updateTicketPosition(param1:Event) : void
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:FoodOrder = null;
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = Number(NaN);
         var _loc11_:Number = Number(NaN);
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:Number = Number(NaN);
         var _loc15_:Number = Number(NaN);
         var _loc16_:Number = Number(NaN);
         var _loc17_:Number = Number(NaN);
         var _loc18_:Ticket = this;
         if(_loc18_.isDragging)
         {
            _loc2_ = _loc18_.maxGrabScale - _loc18_.minGrabScale;
            _loc3_ = (_loc18_.clip.y - _loc18_.minGrabY) / (_loc18_.maxGrabY - _loc18_.minGrabY);
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            else if(_loc3_ > 1)
            {
               _loc3_ = 1;
            }
            _loc4_ = _loc18_.minGrabScale + _loc3_ * _loc2_;
            _loc5_ = (_loc18_.clip.x - _loc18_.minGrabZoomX) / (_loc18_.hangerX - _loc18_.minGrabZoomX);
            if(_loc5_ < 0)
            {
               _loc5_ = 0;
            }
            else if(_loc5_ > 1)
            {
               _loc5_ = 1;
            }
            _loc6_ = _loc18_.minGrabScale + _loc5_ * _loc2_;
            if(_loc6_ > _loc4_)
            {
               _loc4_ = _loc6_;
            }
            _loc7_ = _loc18_.gameObj.var_131.currentOrder;
            if(Boolean((_loc7_) && _loc7_.attachedTicket == null && _loc18_.gameObj.hud.currentStation == "fry") && Boolean(_loc7_.ticketHolderClip) && !_loc7_.isLeavingFry)
            {
               _loc8_ = _loc7_.clip.x + _loc7_.ticketHolderClip.x * _loc7_.clip.scaleX + _loc18_.trayX;
               _loc9_ = _loc7_.clip.y + _loc7_.ticketHolderClip.y * _loc7_.clip.scaleY + _loc18_.trayY;
               _loc10_ = _loc8_ - _loc18_.clip.x;
               _loc11_ = _loc9_ - _loc18_.clip.y;
               _loc12_ = Math.sqrt(_loc10_ * _loc10_ + _loc11_ * _loc11_);
               _loc13_ = 150;
               if(_loc12_ < _loc13_)
               {
                  _loc14_ = _loc18_.minGrabScale + _loc12_ / _loc13_ * _loc2_;
                  if(_loc14_ < _loc18_.trayScale)
                  {
                     _loc14_ = _loc18_.trayScale;
                  }
                  if(_loc14_ < _loc4_)
                  {
                     _loc4_ = _loc14_;
                  }
               }
            }
            _loc18_.clip.scaleX = _loc4_;
            _loc18_.clip.scaleY = _loc4_;
         }
         else if(_loc18_.isMoving)
         {
            _loc15_ = _loc18_.targetX - _loc18_.clip.x;
            _loc16_ = _loc18_.targetY - _loc18_.clip.y;
            _loc17_ = _loc18_.targetScale - _loc18_.clip.scaleX;
            _loc18_.clip.x += _loc15_ / _loc18_.tweenSpeed;
            _loc18_.clip.y += _loc16_ / _loc18_.tweenSpeed;
            _loc18_.clip.scaleX += _loc17_ / _loc18_.tweenSpeed;
            _loc18_.clip.scaleY += _loc17_ / _loc18_.tweenSpeed;
            if(Math.abs(_loc15_) < 1)
            {
               _loc18_.clip.x = _loc18_.targetX;
            }
            if(Math.abs(_loc16_) < 1)
            {
               _loc18_.clip.y = _loc18_.targetY;
            }
            if(Math.abs(_loc17_) < 0.05)
            {
               _loc18_.clip.scaleX = _loc18_.targetScale;
               _loc18_.clip.scaleY = _loc18_.targetScale;
            }
            if(_loc18_.clip.x == _loc18_.targetX && _loc18_.clip.y == _loc18_.targetY)
            {
               _loc18_.clip.scaleX = _loc18_.targetScale;
               _loc18_.clip.scaleY = _loc18_.targetScale;
               _loc18_.isMoving = false;
               _loc18_.clip.removeEventListener(Event.ENTER_FRAME,_loc18_.updateTicketPosition);
               if(_loc18_.isOnTray)
               {
                  _loc18_.gameObj.var_131.currentOrder.attachTicket(_loc18_);
                  _loc18_.gameObj.var_131.currentOrder.moveFromFryScreen();
               }
            }
         }
         if(_loc18_.isDragging && (_loc18_.gameObj.stage.mouseX < 0 || _loc18_.gameObj.mouseX > 640 || _loc18_.gameObj.mouseY < 0 || _loc18_.gameObj.mouseY > 480))
         {
            _loc18_.releaseTicket();
         }
      }
      
      public function drawTicketDetails(param1:Number, param2:Number = -1) : void
      {
         var _loc3_:Ticket = this;
         _loc3_.panelParts[param1].visible = true;
      }
      
      public function finishDrawingTicket() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Ticket = this;
         _loc2_.isDrawingOrder = false;
         _loc2_.bmp = new BitmapData(Math.ceil(_loc2_.clip.width),Math.ceil(_loc2_.clip.height),true,16777215);
         var _loc3_:Rectangle = _loc2_.clip.getBounds(_loc2_.clip);
         var _loc4_:Matrix = new Matrix(1,0,0,1,0 - _loc3_.x,0 - _loc3_.y);
         _loc2_.bmp.draw(_loc2_.clip,_loc4_,null,null,null,true);
         _loc2_.bitmap = new Bitmap(_loc2_.bmp);
         _loc2_.bitmap.smoothing = true;
         _loc2_.clip.addChild(_loc2_.bitmap);
         _loc2_.bitmap.x = _loc3_.x;
         _loc2_.bitmap.y = _loc3_.y;
         if(_loc2_.panelSpecialBitmap)
         {
            _loc2_.panelSpecialBitmap.bitmapData = null;
            if(_loc2_.panelSpecialBitmap.parent)
            {
               _loc2_.panelSpecialBitmap.parent.removeChild(_loc2_.panelSpecialBitmap);
            }
            _loc2_.panelSpecialBitmap = null;
         }
         _loc2_.clip.removeChild(_loc2_.panelHolder);
         if(Boolean(_loc2_.panelSubParts) && _loc2_.panelSubParts.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_.panelSubParts.length)
            {
               _loc2_.panelSubParts[_loc1_].parent.removeChild(_loc2_.panelSubParts[_loc1_]);
               _loc2_.panelSubParts[_loc1_] = null;
               _loc1_++;
            }
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.panelParts.length)
         {
            _loc2_.panelParts[_loc5_].parent.removeChild(_loc2_.panelParts[_loc5_]);
            _loc2_.panelParts[_loc5_] = null;
            _loc5_++;
         }
         _loc2_.panelParts = null;
         _loc2_.panelHolder = null;
         _loc2_.panelSubParts = null;
         _loc2_.clip.number_txt.text = "";
         _loc2_.clip.number_txt.visible = false;
      }
      
      public function destroy() : void
      {
         var ob:Ticket = this;
         if(Boolean(ob.bitmap) && ob.clip.contains(ob.bitmap))
         {
            ob.clip.removeChild(ob.bitmap);
         }
         ob.bitmap = null;
         if(ob.bmp != null)
         {
            ob.bmp.dispose();
            ob.bmp = null;
         }
         if(ob.panelSpecialBitmap)
         {
            ob.panelSpecialBitmap.bitmapData = null;
            if(ob.panelSpecialBitmap.parent)
            {
               ob.panelSpecialBitmap.parent.removeChild(ob.panelSpecialBitmap);
            }
            ob.panelSpecialBitmap = null;
         }
         ob.orderData = null;
         ob.order = null;
         ob.clip.removeEventListener(MouseEvent.MOUSE_DOWN,ob.clickTicket);
         try
         {
            if(ob.clip.parent.contains(ob.clip))
            {
               ob.clip.parent.removeChild(ob.clip);
            }
         }
         catch(err:Error)
         {
            class_7.error("Error removing ticket from parent");
         }
         ob.clip = null;
      }
      
      public function canClickInTraining(param1:Event) : Boolean
      {
         var _loc2_:Ticket = this;
         var _loc3_:class_5 = _loc2_.gameObj;
         var _loc4_:Boolean = false;
         if(_loc3_.training)
         {
            if(_loc3_.method_111(24))
            {
               _loc4_ = true;
            }
         }
         else
         {
            _loc4_ = true;
         }
         return _loc4_;
      }
   }
}

