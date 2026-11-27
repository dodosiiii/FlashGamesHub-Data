package cheeseGame.models
{
   import cheeseGame.data.*;
   import cheeseGame.screens.LobbyEditorScreen;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import package_2.*;
   import package_4.class_5;
   
   public class FurnitureItem
   {
      
      public var gameObj:class_5;
      
      public var clip:MovieClip;
      
      public var container:MovieClip;
      
      public var data:FurniData;
      
      public var xtile:Number;
      
      public var ytile:Number;
      
      public var isDragging:Boolean = true;
      
      public var posterOffsetX:Number = -16;
      
      public var posterOffsetY:Number = -16;
      
      public var furniOffsetX:Number = -16;
      
      public var furniOffsetY:Number = 16;
      
      public var wallX:Number = 117;
      
      public var wallY:Number = 13;
      
      public var floorX:Array;
      
      public var floorY:Array;
      
      public var tileWidth:Number = 32;
      
      public var isLobby:Boolean = false;
      
      public var isOccupied:Boolean = false;
      
      public var hasBeenPlacedOnce:Boolean = false;
      
      public function FurnitureItem(param1:class_5, param2:MovieClip, param3:FurniData, param4:Number = 0, param5:Number = 0, param6:Boolean = true, param7:Boolean = false)
      {
         var _loc8_:FurnitureItem = null;
         this.floorX = [140,121,102];
         this.floorY = [290,358,425];
         super();
         _loc8_ = this;
         _loc8_.gameObj = param1;
         _loc8_.container = param2;
         _loc8_.data = param3;
         _loc8_.xtile = param4;
         _loc8_.ytile = param5;
         _loc8_.isDragging = param6;
         _loc8_.isLobby = param7;
         _loc8_.setupFurni();
      }
      
      public function setupFurni() : void
      {
         var _loc1_:FurnitureItem = this;
         var _loc2_:LobbyEditorScreen = _loc1_.gameObj.var_176;
         var _loc3_:Class = getDefinitionByName(_loc1_.data.tag) as Class;
         _loc1_.clip = new _loc3_();
         _loc1_.container.addChild(_loc1_.clip);
         if(_loc1_.data.tag.indexOf("arcade") == -1)
         {
            _loc1_.clip.cacheAsBitmap = true;
         }
         if(!_loc1_.isDragging)
         {
            if(this.data.type == FurniData.TYPE_POSTER)
            {
               _loc1_.clip.x = _loc1_.wallX + _loc1_.xtile * _loc1_.tileWidth;
               _loc1_.clip.y = _loc1_.wallY + _loc1_.ytile * _loc1_.tileWidth;
            }
            else if(this.data.type == FurniData.TYPE_FURNI)
            {
               _loc1_.clip.x = _loc1_.floorX[_loc1_.ytile] + _loc1_.xtile * _loc1_.tileWidth;
               _loc1_.clip.y = _loc1_.floorY[_loc1_.ytile];
            }
            _loc1_.hasBeenPlacedOnce = true;
         }
         else
         {
            _loc1_.clip.x = _loc2_.clip.mouseX;
            _loc1_.clip.y = _loc2_.clip.mouseY;
            _loc1_.clip.addEventListener(Event.ENTER_FRAME,_loc1_.updateFurni);
         }
         if(!_loc1_.isLobby)
         {
            _loc1_.clip.mouseEnabled = true;
            _loc1_.clip.buttonMode = true;
            _loc1_.clip.useHandCursor = true;
            _loc1_.clip.addEventListener(MouseEvent.MOUSE_UP,_loc1_.selectFurni);
            _loc1_.clip.addEventListener(MouseEvent.ROLL_OVER,_loc1_.rolloverFurni);
            _loc1_.clip.addEventListener(MouseEvent.ROLL_OUT,_loc1_.rolloutFurni);
         }
         else if(_loc1_.data.tag == _loc1_.gameObj.var_133.jukeboxTag || _loc1_.data.tag == _loc1_.gameObj.var_133.boomboxTag || _loc1_.data.tag == _loc1_.gameObj.var_133.phonographTag)
         {
            _loc1_.clip.mouseEnabled = true;
            _loc1_.clip.buttonMode = true;
            _loc1_.clip.useHandCursor = true;
            _loc1_.clip.addEventListener(MouseEvent.MOUSE_UP,_loc1_.toggleMusicVolume);
         }
         if(_loc1_.data.tag == "poster_window" || _loc1_.data.tag == "poster_window2" || _loc1_.data.tag == "poster_window3" || _loc1_.data.tag == "poster_window4")
         {
            if(!_loc1_.isLobby)
            {
               _loc1_.clip.graphics.beginFill(13494015,1);
               _loc1_.clip.graphics.drawRect(0,0,_loc1_.data.width * _loc1_.tileWidth,_loc1_.data.depth * _loc1_.tileWidth);
               _loc1_.clip.graphics.endFill();
            }
            try
            {
               _loc1_.clip.trim.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTrim);
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function updateWindowTint() : void
      {
         var _loc1_:FurnitureItem = this;
         if(_loc1_.data.tag == "poster_window" || _loc1_.data.tag == "poster_window2" || _loc1_.data.tag == "poster_window3" || _loc1_.data.tag == "poster_window4")
         {
            try
            {
               _loc1_.clip.trim.transform.colorTransform = _loc1_.createColorTransform(_loc1_.gameObj.var_128.lobbyTrim);
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function updateFurni(param1:Event = null) : void
      {
         var _loc2_:Point = null;
         var _loc3_:FurnitureItem = this;
         var _loc4_:LobbyEditorScreen = _loc3_.gameObj.var_176;
         if(_loc3_.isDragging)
         {
            _loc2_ = _loc3_.getGridTile();
            if(_loc2_ != null)
            {
               if(_loc3_.data.type == FurniData.TYPE_POSTER)
               {
                  if(_loc4_.isWallGridFree(_loc2_.x,_loc2_.y,this.data.width,this.data.depth))
                  {
                     _loc3_.clip.alpha = 0.9;
                     _loc3_.clip.x = _loc3_.wallX + _loc2_.x * _loc3_.tileWidth;
                     _loc3_.clip.y = _loc3_.wallY + _loc2_.y * _loc3_.tileWidth;
                  }
                  else
                  {
                     _loc3_.clip.alpha = 0.5;
                     _loc3_.clip.x = _loc4_.clip.mouseX + _loc3_.posterOffsetX;
                     _loc3_.clip.y = _loc4_.clip.mouseY + _loc3_.posterOffsetX;
                  }
                  _loc3_.setContainer(_loc4_.clip.wall_layer);
               }
               else if(_loc3_.data.type == FurniData.TYPE_FURNI)
               {
                  if(_loc4_.isFloorGridFree(_loc2_.x,_loc2_.y,this.data.width,this.data.depth))
                  {
                     _loc3_.clip.alpha = 0.9;
                     _loc3_.clip.x = _loc3_.floorX[_loc2_.y] + _loc2_.x * _loc3_.tileWidth;
                     _loc3_.clip.y = _loc3_.floorY[_loc2_.y];
                  }
                  else
                  {
                     _loc3_.clip.alpha = 0.5;
                     _loc3_.clip.x = _loc4_.clip.mouseX + _loc3_.furniOffsetX;
                     _loc3_.clip.y = _loc4_.clip.mouseY + _loc3_.furniOffsetY;
                  }
                  _loc3_.setContainer(_loc4_.clip["floor" + _loc2_.y + "_layer"]);
               }
            }
            else
            {
               _loc3_.clip.alpha = 0.5;
               _loc3_.clip.x = _loc4_.clip.mouseX;
               _loc3_.clip.y = _loc4_.clip.mouseY;
               if(_loc3_.data.type == FurniData.TYPE_POSTER)
               {
                  _loc3_.clip.x += _loc3_.posterOffsetX;
                  _loc3_.clip.y += _loc3_.posterOffsetY;
               }
               else
               {
                  _loc3_.clip.x += _loc3_.furniOffsetX;
                  _loc3_.clip.y += _loc3_.furniOffsetY;
               }
               _loc3_.setContainer(_loc4_.clip.moving_layer);
            }
         }
      }
      
      public function getGridTile() : Point
      {
         var _loc1_:FurnitureItem = this;
         var _loc2_:LobbyEditorScreen = _loc1_.gameObj.var_176;
         var _loc3_:Point = null;
         var _loc4_:Number = _loc2_.clip.mouseX;
         var _loc5_:Number = _loc2_.clip.mouseY;
         var _loc6_:Number = -1;
         var _loc7_:Number = -1;
         if(_loc1_.data.type == FurniData.TYPE_POSTER)
         {
            _loc6_ = Math.floor((_loc4_ - _loc1_.wallX) / _loc1_.tileWidth);
            _loc7_ = Math.floor((_loc5_ - _loc1_.wallY) / _loc1_.tileWidth);
            if(_loc6_ >= 0 && _loc6_ < _loc2_.wallGridWidth && _loc7_ >= 0 && _loc7_ < _loc2_.wallGridHeight)
            {
               _loc3_ = new Point(_loc6_,_loc7_);
            }
         }
         else if(_loc1_.data.type == FurniData.TYPE_FURNI)
         {
            if(_loc5_ >= _loc1_.floorY[0] - _loc1_.tileWidth && _loc5_ <= _loc1_.floorY[0])
            {
               _loc7_ = 0;
            }
            else if(_loc5_ >= _loc1_.floorY[1] - _loc1_.tileWidth && _loc5_ <= _loc1_.floorY[1])
            {
               _loc7_ = 1;
            }
            else if(_loc5_ >= _loc1_.floorY[2] - _loc1_.tileWidth && _loc5_ <= _loc1_.floorY[2])
            {
               _loc7_ = 2;
            }
            if(_loc7_ > -1)
            {
               _loc6_ = Math.floor((_loc4_ - _loc1_.floorX[_loc7_]) / _loc1_.tileWidth);
               if(_loc6_ >= 0 && _loc6_ < _loc2_.floorGridWidth && _loc7_ >= 0 && _loc7_ < _loc2_.floorGridHeight)
               {
                  _loc3_ = new Point(_loc6_,_loc7_);
               }
            }
         }
         return _loc3_;
      }
      
      public function setContainer(param1:MovieClip) : void
      {
         var _loc2_:FurnitureItem = this;
         if(_loc2_.container != param1)
         {
            _loc2_.container = param1;
            if(!_loc2_.container.contains(_loc2_.clip))
            {
               _loc2_.container.addChild(_loc2_.clip);
            }
            else
            {
               _loc2_.container.setChildIndex(_loc2_.clip,_loc2_.container.numChildren - 1);
            }
         }
         else
         {
            _loc2_.container.setChildIndex(_loc2_.clip,_loc2_.container.numChildren - 1);
         }
      }
      
      public function selectFurni(param1:MouseEvent) : void
      {
         var _loc2_:FurnitureItem = this;
         var _loc3_:LobbyEditorScreen = _loc2_.gameObj.var_176;
         if(!_loc2_.isDragging && _loc3_.activeFurni == null)
         {
            _loc2_.gameObj.var_129.playSound("grabtopping.wav");
            _loc2_.isDragging = true;
            _loc3_.pickupFurni(_loc2_.data,_loc2_.xtile,_loc2_.ytile);
            _loc3_.setActiveFurni(_loc2_);
            if(!_loc2_.clip.hasEventListener(Event.ENTER_FRAME))
            {
               _loc2_.clip.addEventListener(Event.ENTER_FRAME,_loc2_.updateFurni);
            }
            _loc3_.shouldShowPutAway = true;
            _loc3_.showTrimPopup = false;
            _loc3_.showTopPopup = false;
            _loc3_.hideFurniHUD(null,true);
            param1.stopImmediatePropagation();
         }
      }
      
      public function rolloverFurni(param1:MouseEvent) : void
      {
         var _loc2_:FurnitureItem = this;
         var _loc3_:LobbyEditorScreen = _loc2_.gameObj.var_176;
         if(!_loc2_.isDragging && !_loc2_.isLobby && _loc3_.activeFurni == null)
         {
            _loc3_.showFurniHUD(_loc2_);
         }
      }
      
      public function rolloutFurni(param1:MouseEvent) : void
      {
         var _loc2_:FurnitureItem = this;
         var _loc3_:LobbyEditorScreen = _loc2_.gameObj.var_176;
         if(!_loc2_.isDragging && !_loc2_.isLobby)
         {
            _loc3_.hideFurniHUD(_loc2_);
         }
      }
      
      public function clickFurni(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:FurnitureItem = this;
         var _loc4_:LobbyEditorScreen = _loc3_.gameObj.var_176;
         if(_loc3_.isDragging)
         {
            _loc2_ = _loc3_.getGridTile();
            if(_loc2_ != null)
            {
               if(_loc3_.data.type == FurniData.TYPE_POSTER)
               {
                  if(_loc4_.isWallGridFree(_loc2_.x,_loc2_.y,this.data.width,this.data.depth))
                  {
                     _loc3_.clip.alpha = 1;
                     _loc3_.clip.x = _loc3_.wallX + _loc2_.x * _loc3_.tileWidth;
                     _loc3_.clip.y = _loc3_.wallY + _loc2_.y * _loc3_.tileWidth;
                     _loc4_.placeFurni(_loc3_.data,_loc2_.x,_loc2_.y);
                     if(!_loc3_.hasBeenPlacedOnce)
                     {
                        _loc4_.gradeLayout(_loc3_.data,_loc3_.clip.x + _loc3_.clip.width / 2,_loc3_.clip.y + _loc3_.clip.height);
                        _loc3_.hasBeenPlacedOnce = true;
                     }
                     else
                     {
                        _loc4_.gradeLayout();
                     }
                     _loc3_.xtile = _loc2_.x;
                     _loc3_.ytile = _loc2_.y;
                     if(_loc4_.activeFurni == _loc3_)
                     {
                        _loc4_.activeFurni = null;
                     }
                     _loc3_.setContainer(_loc4_.clip.wall_layer);
                     _loc3_.clip.removeEventListener(Event.ENTER_FRAME,_loc3_.updateFurni);
                     _loc3_.isDragging = false;
                     _loc4_.shouldShowPutAway = false;
                     _loc4_.showTrimPopup = false;
                     _loc4_.showTopPopup = false;
                     if(!_loc3_.gameObj.var_128.hasPlacedFurniture)
                     {
                        _loc3_.gameObj.var_128.hasPlacedFurniture = true;
                     }
                     _loc3_.gameObj.var_129.playSound("droptopping.wav");
                  }
               }
               else if(_loc3_.data.type == FurniData.TYPE_FURNI)
               {
                  if(_loc4_.isFloorGridFree(_loc2_.x,_loc2_.y,this.data.width,this.data.depth))
                  {
                     _loc3_.clip.alpha = 1;
                     _loc3_.clip.x = _loc3_.floorX[_loc2_.y] + _loc2_.x * _loc3_.tileWidth;
                     _loc3_.clip.y = _loc3_.floorY[_loc2_.y];
                     _loc4_.placeFurni(_loc3_.data,_loc2_.x,_loc2_.y);
                     if(!_loc3_.hasBeenPlacedOnce)
                     {
                        _loc4_.gradeLayout(_loc3_.data,_loc3_.clip.x + _loc3_.clip.width / 2,_loc3_.clip.y - _loc3_.clip.height);
                        _loc3_.hasBeenPlacedOnce = true;
                     }
                     else
                     {
                        _loc4_.gradeLayout();
                     }
                     _loc3_.xtile = _loc2_.x;
                     _loc3_.ytile = _loc2_.y;
                     if(_loc4_.activeFurni == _loc3_)
                     {
                        _loc4_.activeFurni = null;
                     }
                     _loc3_.setContainer(_loc4_.clip["floor" + _loc3_.ytile + "_layer"]);
                     _loc3_.clip.removeEventListener(Event.ENTER_FRAME,_loc3_.updateFurni);
                     _loc3_.isDragging = false;
                     _loc4_.shouldShowPutAway = false;
                     _loc4_.showTrimPopup = false;
                     _loc4_.showTopPopup = false;
                     if(!_loc3_.gameObj.var_128.hasPlacedFurniture)
                     {
                        _loc3_.gameObj.var_128.hasPlacedFurniture = true;
                     }
                     _loc3_.gameObj.var_129.playSound("droptopping.wav");
                  }
               }
            }
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:FurnitureItem = this;
         if(!_loc1_.isLobby)
         {
            _loc1_.clip.removeEventListener(MouseEvent.MOUSE_UP,_loc1_.selectFurni);
            _loc1_.clip.removeEventListener(MouseEvent.ROLL_OVER,_loc1_.rolloverFurni);
            _loc1_.clip.removeEventListener(MouseEvent.ROLL_OUT,_loc1_.rolloutFurni);
         }
         else if(_loc1_.data.tag == _loc1_.gameObj.var_133.jukeboxTag || _loc1_.data.tag == _loc1_.gameObj.var_133.boomboxTag || _loc1_.data.tag == _loc1_.gameObj.var_133.phonographTag)
         {
            _loc1_.clip.removeEventListener(MouseEvent.MOUSE_UP,_loc1_.toggleMusicVolume);
         }
         if(_loc1_.clip.hasEventListener(Event.ENTER_FRAME))
         {
            _loc1_.clip.removeEventListener(Event.ENTER_FRAME,_loc1_.updateFurni);
         }
         if(Boolean(_loc1_.container) && _loc1_.container.contains(_loc1_.clip))
         {
            _loc1_.container.removeChild(_loc1_.clip);
         }
         _loc1_.container = null;
         _loc1_.clip = null;
      }
      
      public function toggleMusicVolume(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var ob:FurnitureItem = this;
         try
         {
            ob.gameObj.var_145.toggleMusicMute(ob.data.tag);
         }
         catch(err:Error)
         {
            class_7.method_1("Error with toggling volume on furni.");
         }
      }
      
      private function createColorTransform(param1:Number) : ColorTransform
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redMultiplier = ((param1 & 0xFF0000) >>> 16) / 255;
         _loc2_.greenMultiplier = ((param1 & 0xFF00) >>> 8) / 255;
         _loc2_.blueMultiplier = (param1 & 0xFF) / 255;
         return _loc2_;
      }
   }
}

