package cheeseGame.screens
{
   import cheeseGame.models.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.SoundChannel;
   import flash.utils.*;
   import package_2.*;
   
   public class MiniGameKart extends MiniGame
   {
      
      public var whichDifficulty:Number = 1;
      
      public var isIntro:Boolean = true;
      
      public var introTimer:Number = 0;
      
      public var introTimerMax:Number = 60;
      
      public var targetAmount:Number = 0;
      
      public var frontParts:Vector.<Bitmap>;
      
      public var midParts:Vector.<Bitmap>;
      
      public var backParts:Vector.<Bitmap>;
      
      public var backdrop:Bitmap;
      
      public var backStartX:Number = 0;
      
      public var backStartY:Number = 4;
      
      public var midStartX:Number = 0;
      
      public var midStartY:Number = 0;
      
      public var frontStartX:Number = 0;
      
      public var frontStartY:Number = 0;
      
      public var kartAccel:Number = 0.15;
      
      public var startingSpeed:Number = 6;
      
      public var maxSpeed:Number = 12;
      
      public var useSpeed:Number = 0;
      
      public var useFrame:Number = 0;
      
      public var raceOffset:Number = 0;
      
      public var lastScreenX:Number = 0;
      
      public var finishDecaySpeed:Number = 2147483647;
      
      public var kart:GoKart;
      
      public var isHit:Boolean = false;
      
      public var isFinishing:Boolean = false;
      
      public var finishRank:Number = -1;
      
      public var spaceIsDown:Boolean = false;
      
      public var whichFireworks:Number = 1;
      
      public var showingBanner:Boolean = false;
      
      public var bannerTargetY:Number = 48;
      
      public var bannerTimer:Number = 0;
      
      public var bannerDuration:Number = 45;
      
      public var layerHolders:Array = [];
      
      public var layersY:Array = [225,261,297,333,369];
      
      public var kartLane:Number = 0;
      
      public var kartStartX:Number = 180;
      
      public var kartMinY:Number = 225;
      
      public var kartMaxY:Number = 369;
      
      public var canRandomizeCustomers:Boolean = false;
      
      public var objects:Vector.<KartObject>;
      
      public var karts:Vector.<GoKart>;
      
      public var movementTimer:Number = 0;
      
      public var didSlot:Number = -1;
      
      public var lastTime:Number = 0;
      
      public var currFrame:Number = 0;
      
      public var coinsCollected:Number = 0;
      
      public var didTriggerEnd:Boolean = false;
      
      public var allCustomers:Array = ["Wally","Akari","SargeFan","Marty","Boomer","Radlynn","Rico","Willow","Hank","ProfessorFitz","Xandra","Foodini","Ember","Johnny","Sasha","Nick"];
      
      public var kartData:Array = [[{
         "customer":"Sasha",
         "maxSpeed":12.1,
         "startingSpeed":7,
         "accel":0.1,
         "avoid":0.2,
         "collect":0.02
      },{
         "customer":"SargeFan",
         "maxSpeed":12.1,
         "startingSpeed":6,
         "accel":0.08,
         "avoid":0.4,
         "collect":0.02
      }],[{
         "customer":"Hank",
         "maxSpeed":12.2,
         "startingSpeed":7,
         "accel":0.1,
         "avoid":1,
         "collect":0.06
      },{
         "customer":"Sasha",
         "maxSpeed":12.3,
         "startingSpeed":6,
         "accel":0.08,
         "avoid":0.7,
         "collect":0.06
      }],[{
         "customer":"Ember",
         "maxSpeed":12.2,
         "startingSpeed":7,
         "accel":0.1,
         "avoid":0.3,
         "collect":0.07
      },{
         "customer":"Hank",
         "maxSpeed":12.2,
         "startingSpeed":6,
         "accel":0.2,
         "avoid":0.8,
         "collect":0.07
      }],[{
         "customer":"Rico",
         "maxSpeed":13,
         "startingSpeed":7,
         "accel":0.05,
         "avoid":0.7,
         "collect":0.6
      },{
         "customer":"Ember",
         "maxSpeed":12.2,
         "startingSpeed":6,
         "accel":0.08,
         "avoid":0.3,
         "collect":0.02
      }],[{
         "customer":"Akari",
         "maxSpeed":12.6,
         "startingSpeed":7,
         "accel":0.09,
         "avoid":0.7,
         "collect":0.3
      },{
         "customer":"Rico",
         "maxSpeed":12.4,
         "startingSpeed":6,
         "accel":0.09,
         "avoid":0.7,
         "collect":0.8
      }],[{
         "customer":"Marty",
         "maxSpeed":13,
         "startingSpeed":6,
         "accel":0.08,
         "avoid":0.6,
         "collect":0.7
      },{
         "customer":"Johnny",
         "maxSpeed":13.2,
         "startingSpeed":6,
         "accel":0.07,
         "avoid":0.8,
         "collect":0.3
      }],[{
         "customer":"Johnny",
         "maxSpeed":12.6,
         "startingSpeed":7,
         "accel":0.07,
         "avoid":0.5,
         "collect":0.3
      },{
         "customer":"ProfessorFitz",
         "maxSpeed":12.6,
         "startingSpeed":5,
         "accel":0.16,
         "avoid":0.6,
         "collect":0.6
      }],[{
         "customer":"Boomer",
         "maxSpeed":12.4,
         "startingSpeed":4,
         "accel":0.18,
         "avoid":0.8,
         "collect":0.08
      },{
         "customer":"Nick",
         "maxSpeed":12.6,
         "startingSpeed":4.5,
         "accel":0.17,
         "avoid":0.7,
         "collect":0.7
      }],[{
         "customer":"Nick",
         "maxSpeed":12.6,
         "startingSpeed":5,
         "accel":0.1,
         "avoid":0.8,
         "collect":0.7
      },{
         "customer":"Wally",
         "maxSpeed":12.5,
         "startingSpeed":4.5,
         "accel":0.17,
         "avoid":0.7,
         "collect":0.8
      }],[{
         "customer":"Wally",
         "maxSpeed":12.6,
         "startingSpeed":4.5,
         "accel":0.1,
         "avoid":0.4,
         "collect":0.7
      },{
         "customer":"Willow",
         "maxSpeed":12.6,
         "startingSpeed":5.5,
         "accel":0.1,
         "avoid":0.8,
         "collect":0.2
      }],[{
         "customer":"Willow",
         "maxSpeed":12.4,
         "startingSpeed":4.6,
         "accel":0.11,
         "avoid":0.7,
         "collect":0.7
      },{
         "customer":"Boomer",
         "maxSpeed":12.6,
         "startingSpeed":5,
         "accel":0.12,
         "avoid":0.7,
         "collect":0.7
      }],[{
         "customer":"Radlynn",
         "maxSpeed":12.6,
         "startingSpeed":4.5,
         "accel":0.1,
         "avoid":0.7,
         "collect":0.7
      },{
         "customer":"Foodini",
         "maxSpeed":12.5,
         "startingSpeed":5.5,
         "accel":0.16,
         "avoid":0.7,
         "collect":0.7
      }],[{
         "customer":"Xandra",
         "maxSpeed":12.3,
         "startingSpeed":4.5,
         "accel":0.12,
         "avoid":0.8,
         "collect":0.8
      },{
         "customer":"ProfessorFitz",
         "maxSpeed":12.4,
         "startingSpeed":5.5,
         "accel":0.16,
         "avoid":0.8,
         "collect":0.8
      }],[{
         "customer":"Foodini",
         "maxSpeed":14,
         "startingSpeed":4.5,
         "accel":0.06,
         "avoid":0.9,
         "collect":0.9
      },{
         "customer":"Xandra",
         "maxSpeed":12.4,
         "startingSpeed":6,
         "accel":0.19,
         "avoid":0.9,
         "collect":0.9
      }]];
      
      public var targetAmounts:Array = [14,21,26,32,35,35,36,38,31,30,28,36,30,29];
      
      public var layouts:Array = [[[undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,8,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined
      ,undefined,8,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,0,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined],[0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,0,undefined,undefined,undefined]],[[undefined,0,undefined,undefined,undefined,undefined,0,undefined
      ,undefined,0,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined],[undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,8,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined],[0,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,8,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,8,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined],[0,0,undefined,undefined,undefined,0,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,1,undefined,undefined,undefined,undefined,undefined,undefined,0
      ,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined]],[[5,undefined,undefined,0,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,0,0,0,0,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[5,0,undefined,undefined,undefined,0,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,8,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,1],[undefined,undefined,undefined,undefined,0,undefined,0,undefined
      ,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[5,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,0,0,0,0,0,1,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined
      ,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined]],[[undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,8,undefined,0,0,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,0,0],[0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1],[0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0],[undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined]],[[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,1,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined],[0,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined],[undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,0,undefined,undefined,5,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,8,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[0,undefined,undefined,8,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,0,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined],[0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined
      ,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined]],[[undefined,undefined,0,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined
      ,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined],[1,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined
      ,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,5,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,5,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined]],[[0,undefined,undefined,undefined,undefined,1,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,0,undefined,undefined,undefined
      ,undefined,undefined,undefined,1,undefined],[0,undefined,undefined,0,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,8,undefined,undefined,undefined,0,undefined,undefined,undefined],[0,undefined,undefined,undefined,undefined,1,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined]],[[undefined,0,undefined,undefined
      ,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined],[8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,0,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined],[undefined,0,undefined,undefined,0,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined,1,1,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,1,undefined],[0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,1
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined
      ,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,0,undefined,1,undefined]],[[1,undefined,0,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,0,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,0,0,1,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1],[1,undefined,0,0,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,0,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined],[undefined,0,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined]],[[undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined],[8,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined
      ,undefined,undefined,0,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,0,undefined,undefined,0,8,undefined,undefined,undefined,undefined,8,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined
      ,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,0,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,8,undefined,undefined,undefined,0],[undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0
      ,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined]],[[undefined,0,5,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,0,undefined,0,0,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined]
      ,[undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined],[5,undefined,undefined,0,0,0,undefined,undefined,8,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,8,undefined,undefined,undefined,undefined,0,undefined
      ,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,1,1,1,undefined,undefined,undefined],[undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,8,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined],[undefined,0,5,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,0,0,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined]],[[1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,0,0,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,0,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined],[undefined,1,undefined,undefined,undefined,0,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined
      ,undefined,undefined,undefined,5,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,0,0,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined
      ,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,1,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined]],[[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,5,undefined,undefined,undefined,0,0,0,undefined,undefined,undefined],[0,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,0,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined
      ,undefined,undefined,0,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined]],[[1,undefined,0,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined
      ,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,5,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,8,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,0,undefined,undefined,undefined,undefined,0,undefined,1,undefined],[undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined
      ,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,1,1,undefined,undefined,0,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined],[undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,8,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0,undefined,undefined,undefined,undefined,undefined,undefined
      ,undefined,undefined,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,0]]];
      
      public var levelData:Array;
      
      public var idleSound:SoundChannel = null;
      
      public function MiniGameKart(param1:MiniGameScreen, param2:MovieClip, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function setupScreen() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MiniGameKart = this;
         _loc2_.clip = new minigameKartMC();
         _loc2_.container.addChild(_loc2_.clip);
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = new MovieClip();
            _loc2_.clip.holder.addChild(_loc1_);
            _loc2_.layerHolders.push(_loc1_);
            _loc3_++;
         }
         _loc2_.objects = new Vector.<KartObject>();
         _loc2_.screen.setTitle("Papa\'s Raceway");
         _loc2_.setupPrizes(_loc2_.type);
         _loc2_.screen.updateStars();
         _loc2_.reset();
         _loc2_.clip.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.clickScreen);
      }
      
      public function reset(param1:MouseEvent = null) : void
      {
         var _loc2_:MiniGameKart = this;
         _loc2_.decideDifficulty();
         _loc2_.showBanner();
         _loc2_.coinsCollected = 0;
         _loc2_.raceOffset = 0;
         _loc2_.lastScreenX = 0;
         _loc2_.didSlot = -1;
         _loc2_.movementTimer = 0;
         _loc2_.setupBackdrop(false);
         _loc2_.clearObjects();
         _loc2_.setupBackdrop();
         _loc2_.setupKarts(false);
         _loc2_.setupKarts(true);
         _loc2_.isFinishing = false;
         _loc2_.isIntro = true;
         _loc2_.introTimer = 0;
         _loc2_.isHit = false;
         var _loc3_:KartObject = new KartObject(_loc2_,_loc2_.clip.holder,KartObject.TYPE_STARTLINE,0,75,0);
         _loc2_.objects.push(_loc3_);
         _loc2_.updateAllKarts();
         _loc2_.depthSort();
         if(_loc2_.idleSound == null)
         {
            _loc2_.idleSound = _loc2_.screen.gameObj.var_129.playSound("minigame_kart_idling.wav",true,0.1);
         }
      }
      
      public function decideDifficulty() : void
      {
         var _loc1_:MiniGameKart = this;
         var _loc2_:Number = _loc1_.getStartingLevel();
         if(_loc2_ < 14)
         {
            _loc1_.whichDifficulty = _loc2_ + 1;
            _loc1_.canRandomizeCustomers = false;
         }
         else
         {
            _loc1_.whichDifficulty = 5 + Math.ceil(Math.random() * 9);
            _loc1_.canRandomizeCustomers = true;
         }
         _loc1_.levelData = _loc1_.layouts[_loc1_.whichDifficulty - 1];
         _loc1_.targetAmount = _loc1_.targetAmounts[_loc1_.whichDifficulty - 1];
      }
      
      override public function updateScreen() : void
      {
         var _loc1_:MiniGameKart = this;
         ++_loc1_.currFrame;
         if(_loc1_.showingBanner)
         {
            if(_loc1_.clip.banner.y < _loc1_.bannerTargetY)
            {
               _loc1_.clip.banner.y += (_loc1_.bannerTargetY - _loc1_.clip.banner.y) / 4;
               if(Math.abs(_loc1_.bannerTargetY - _loc1_.clip.banner.y) < 1)
               {
                  _loc1_.clip.banner.y = _loc1_.bannerTargetY;
               }
            }
            else
            {
               ++_loc1_.bannerTimer;
               if(_loc1_.bannerTimer >= _loc1_.bannerDuration)
               {
                  _loc1_.showingBanner = false;
               }
            }
         }
         else if(_loc1_.clip.banner.y > -70)
         {
            _loc1_.clip.banner.y += (-70 - _loc1_.clip.banner.y) / 10;
            if(Math.abs(-70 - _loc1_.clip.banner.y) < 1)
            {
               _loc1_.clip.banner.y = -70;
            }
         }
         if(_loc1_.kart != null)
         {
            _loc1_.useSpeed = _loc1_.kart.speed;
         }
         if(_loc1_.isIntro)
         {
            ++_loc1_.introTimer;
            if(_loc1_.introTimer >= _loc1_.introTimerMax)
            {
               _loc1_.isIntro = false;
               _loc1_.startMoving();
            }
            else if(_loc1_.introTimer >= _loc1_.introTimerMax / 2)
            {
            }
         }
         else
         {
            _loc1_.updateAllKarts();
            _loc1_.animateScrolling();
            _loc1_.updateObjects();
            _loc1_.depthSort();
            if(_loc1_.isFinishing && _loc1_.kart && _loc1_.kart.clip.x > 1200)
            {
               if(!_loc1_.didTriggerEnd)
               {
                  trace("DONE");
                  _loc1_.screen.finishMiniGame(_loc1_.skuToWin,_loc1_.amountToWin,_loc1_.skuIsClothing,_loc1_.skuClothingMode);
                  _loc1_.didTriggerEnd = true;
               }
            }
         }
         var _loc2_:Number = Number(getTimer());
         var _loc3_:Number = Math.round(1000 / (_loc2_ - this.lastTime));
         if(_loc2_ == this.lastTime)
         {
            _loc3_ = 0;
         }
         _loc1_.clip.fps_txt.text = _loc3_ + " fps";
         _loc1_.lastTime = _loc2_;
      }
      
      public function startMoving() : void
      {
         trace("START!");
         var _loc1_:MiniGameKart = this;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.karts.length)
         {
            if(_loc2_ == 0)
            {
               _loc1_.karts[_loc2_].startDrivingSound(true);
            }
            else
            {
               _loc1_.karts[_loc2_].startDrivingSound(false);
            }
            _loc2_++;
         }
         if(_loc1_.idleSound)
         {
            _loc1_.idleSound.stop();
            _loc1_.idleSound = null;
         }
         _loc1_.screen.gameObj.var_129.playSound("minigame_kart_start.wav",false,0.5);
      }
      
      public function setupBackdrop(param1:Boolean = true) : void
      {
         var §~~unused§:*;
         var _loc17_:MiniGameKart;
         var _loc18_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:BitmapData = null;
         var _loc5_:MovieClip = null;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Bitmap = null;
         var _loc9_:MovieClip = null;
         var _loc10_:BitmapData = null;
         var _loc11_:Bitmap = null;
         var _loc12_:Bitmap = null;
         var _loc13_:MovieClip = null;
         var _loc14_:BitmapData = null;
         var _loc15_:Bitmap = null;
         var _loc16_:Bitmap = null;
         if((_loc18_ = (_loc17_ = this).screen.gameObj.var_128.getHolidayMonth()) == 0)
         {
            _loc18_ = 13;
         }
         _loc17_.useFrame = 2 * _loc18_ - 1;
         if(param1)
         {
            _loc17_.frontParts = new Vector.<Bitmap>();
            _loc17_.midParts = new Vector.<Bitmap>();
            _loc17_.backParts = new Vector.<Bitmap>();
            (_loc3_ = new outside_minigamekart_backdrop()).gotoAndStop(this.useFrame);
            (_loc4_ = new BitmapData(640,320,true,0)).draw(_loc3_);
            _loc17_.backdrop = new Bitmap(_loc4_);
            _loc17_.backdrop.x = 0;
            _loc17_.backdrop.y = 3;
            _loc17_.clip.bgholder.addChild(_loc17_.backdrop);
            (_loc5_ = new outside_minigamekart_backplane()).gotoAndStop(this.useFrame);
            (_loc6_ = new BitmapData(640,320,true,0)).draw(_loc5_);
            (_loc7_ = new Bitmap(_loc6_)).x = 0;
            _loc7_.y = 4;
            _loc17_.backParts.push(_loc7_);
            _loc17_.clip.bgholder.addChild(_loc7_);
            (_loc8_ = new Bitmap(_loc6_)).x = 640;
            _loc8_.y = 4;
            _loc17_.backParts.push(_loc8_);
            _loc17_.clip.bgholder.addChild(_loc8_);
            (_loc9_ = new outside_minigamekart_midplane()).gotoAndStop(this.useFrame);
            (_loc10_ = new BitmapData(640,320,true,0)).draw(_loc9_);
            (_loc11_ = new Bitmap(_loc10_)).x = 0;
            _loc11_.y = 0;
            _loc17_.midParts.push(_loc11_);
            _loc17_.clip.bgholder.addChild(_loc11_);
            (_loc12_ = new Bitmap(_loc10_)).x = 640;
            _loc12_.y = 0;
            _loc17_.midParts.push(_loc12_);
            _loc17_.clip.bgholder.addChild(_loc12_);
            (_loc13_ = new outside_minigamekart_mainplane()).gotoAndStop(this.useFrame);
            (_loc14_ = new BitmapData(640,480,true,0)).draw(_loc13_);
            (_loc15_ = new Bitmap(_loc14_)).x = 0;
            _loc15_.y = 0;
            _loc17_.frontParts.push(_loc15_);
            _loc17_.clip.bgholder.addChild(_loc15_);
            (_loc16_ = new Bitmap(_loc14_)).x = 640;
            _loc16_.y = 0;
            _loc17_.frontParts.push(_loc16_);
            _loc17_.clip.bgholder.addChild(_loc16_);
            _loc13_ = null;
            _loc9_ = null;
            _loc5_ = null;
         }
         else if(Boolean(_loc17_.frontParts) && _loc17_.frontParts.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc17_.frontParts.length)
            {
               _loc17_.clip.bgholder.removeChild(_loc17_.frontParts[_loc2_]);
               try
               {
                  _loc17_.frontParts[_loc2_].bitmapData.dispose();
                  _loc17_.frontParts[_loc2_].bitmapData = null;
               }
               catch(err:Error)
               {
               }
               _loc17_.frontParts[_loc2_] = null;
               _loc2_++;
            }
            _loc17_.frontParts = null;
            _loc2_ = 0;
            while(_loc2_ < _loc17_.midParts.length)
            {
               _loc17_.clip.bgholder.removeChild(_loc17_.midParts[_loc2_]);
               try
               {
                  _loc17_.midParts[_loc2_].bitmapData.dispose();
                  _loc17_.midParts[_loc2_].bitmapData = null;
               }
               catch(err:Error)
               {
               }
               _loc17_.midParts[_loc2_] = null;
               _loc2_++;
            }
            _loc17_.midParts = null;
            _loc2_ = 0;
            while(_loc2_ < _loc17_.backParts.length)
            {
               _loc17_.clip.bgholder.removeChild(_loc17_.backParts[_loc2_]);
               try
               {
                  _loc17_.backParts[_loc2_].bitmapData.dispose();
                  _loc17_.backParts[_loc2_].bitmapData = null;
               }
               catch(err:Error)
               {
               }
               _loc17_.backParts[_loc2_] = null;
               _loc2_++;
            }
            _loc17_.backParts = null;
            if(_loc17_.backdrop)
            {
               if(_loc17_.backdrop.bitmapData)
               {
                  _loc17_.backdrop.bitmapData.dispose();
                  _loc17_.backdrop.bitmapData = null;
               }
               _loc17_.backdrop.parent.removeChild(_loc17_.backdrop);
               _loc17_.backdrop = null;
            }
         }
      }
      
      public function animateScrolling() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:MiniGameKart = this;
         if(!_loc4_.isHit)
         {
            _loc2_ = 0;
            if(_loc4_.kart != null)
            {
               _loc2_ = _loc4_.kart.x;
            }
            _loc3_ = _loc2_ - _loc4_.lastScreenX;
            if(_loc4_.isFinishing && _loc4_.finishDecaySpeed < int.MAX_VALUE)
            {
               _loc2_ = _loc4_.lastScreenX + _loc4_.finishDecaySpeed;
               _loc3_ = _loc2_ - _loc4_.lastScreenX;
               --_loc4_.finishDecaySpeed;
               if(_loc4_.finishDecaySpeed < 0)
               {
                  _loc4_.finishDecaySpeed = 0;
               }
            }
            _loc1_ = 0;
            while(_loc1_ < _loc4_.backParts.length)
            {
               _loc4_.backParts[_loc1_].x -= Math.round(_loc3_ * 0.3);
               if(_loc4_.backParts[_loc1_].x + _loc4_.backParts[_loc1_].width < _loc4_.backStartX)
               {
                  _loc4_.backParts[_loc1_].x += 1280;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < _loc4_.midParts.length)
            {
               _loc4_.midParts[_loc1_].x -= Math.round(_loc3_ * 0.6);
               if(_loc4_.midParts[_loc1_].x + _loc4_.midParts[_loc1_].width < _loc4_.midStartX)
               {
                  _loc4_.midParts[_loc1_].x += 1280;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < _loc4_.frontParts.length)
            {
               _loc4_.frontParts[_loc1_].x -= Math.round(_loc3_);
               if(_loc4_.frontParts[_loc1_].x + _loc4_.frontParts[_loc1_].width < _loc4_.frontStartX)
               {
                  _loc4_.frontParts[_loc1_].x += 1280;
               }
               _loc1_++;
            }
            _loc4_.raceOffset = _loc2_;
            _loc4_.lastScreenX = _loc2_;
         }
      }
      
      public function clearObjects() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MiniGameKart = this;
         if(_loc2_.objects)
         {
            _loc1_ = int(_loc2_.objects.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc2_.objects[_loc1_] != null)
               {
                  _loc2_.objects[_loc1_].destroy();
                  _loc2_.objects[_loc1_] = null;
                  _loc2_.objects.splice(_loc1_,1);
               }
               _loc1_--;
            }
         }
      }
      
      public function updateObjects() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:int = 0;
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:KartObject = null;
         var _loc9_:KartObject = null;
         var _loc10_:KartObject = null;
         var _loc11_:KartObject = null;
         var _loc12_:Number = Number(NaN);
         var _loc13_:Number = Number(NaN);
         var _loc14_:KartObject = null;
         var _loc15_:KartObject = null;
         var _loc16_:MiniGameKart = this;
         if(_loc16_.objects)
         {
            _loc1_ = int(_loc16_.objects.length - 1);
            while(_loc1_ >= 0)
            {
               if(_loc16_.objects[_loc1_] != null)
               {
                  _loc16_.objects[_loc1_].updateObject();
               }
               _loc1_--;
            }
            _loc2_ = 640;
            _loc3_ = Math.floor((_loc16_.kart.x - _loc16_.kartStartX) / 128);
            if(_loc16_.didSlot < _loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc16_.levelData.length)
               {
                  _loc5_ = Math.round(_loc16_.kart.x + _loc2_);
                  _loc6_ = _loc16_.layersY[_loc4_] + 10;
                  _loc7_ = _loc16_.currFrame * 10 + _loc4_;
                  if(_loc3_ < _loc16_.levelData[_loc4_].length)
                  {
                     if(_loc16_.levelData[_loc4_][_loc3_] == 8)
                     {
                        _loc8_ = new KartObject(_loc16_,_loc16_.clip.holder,KartObject.TYPE_OILSLICK,_loc7_,_loc5_,_loc6_);
                        _loc16_.objects.push(_loc8_);
                     }
                     else if(_loc16_.levelData[_loc4_][_loc3_] == 5)
                     {
                        _loc9_ = new KartObject(_loc16_,_loc16_.clip.holder,KartObject.TYPE_BOOSTPAD,_loc7_,_loc5_,_loc6_);
                        _loc16_.objects.push(_loc9_);
                     }
                     else if(_loc16_.levelData[_loc4_][_loc3_] == 1)
                     {
                        _loc10_ = new KartObject(_loc16_,_loc16_.clip.kartholder,KartObject.TYPE_CONE,_loc7_,_loc5_,_loc6_);
                        _loc16_.objects.push(_loc10_);
                     }
                     else if(_loc16_.levelData[_loc4_][_loc3_] == 0)
                     {
                        _loc11_ = new KartObject(_loc16_,_loc16_.clip.kartholder,KartObject.TYPE_COIN,_loc7_,_loc5_,_loc6_);
                        _loc16_.objects.push(_loc11_);
                     }
                  }
                  else if(_loc3_ == _loc16_.levelData[_loc4_].length && _loc4_ == 0)
                  {
                     trace("----------- OUT OF SLOTS --------------");
                  }
                  _loc4_++;
               }
               if(_loc3_ == _loc16_.levelData[0].length + 2)
               {
                  trace("ADD FINISH STUFF");
                  _loc12_ = _loc16_.kart.x + _loc2_;
                  _loc13_ = _loc16_.currFrame * 10;
                  _loc14_ = new KartObject(_loc16_,_loc16_.clip.holder,KartObject.TYPE_FINISHLINE,_loc13_,_loc12_,0);
                  _loc16_.objects.push(_loc14_);
                  _loc15_ = new KartObject(_loc16_,_loc16_.clip.kartholder,KartObject.TYPE_FINISHBANNER,_loc13_,_loc12_,640);
                  _loc16_.objects.push(_loc15_);
               }
               _loc16_.didSlot = _loc3_;
            }
         }
      }
      
      public function removeObject(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MiniGameKart = this;
         if(_loc3_.objects)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.objects.length)
            {
               if(_loc3_.objects[_loc2_] != null && _loc3_.objects[_loc2_].id == param1)
               {
                  _loc3_.objects[_loc2_].destroy();
                  _loc3_.objects[_loc2_] = null;
                  _loc3_.objects.splice(_loc2_,1);
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public function clickScreen(param1:MouseEvent) : void
      {
         var _loc2_:MiniGameKart = this;
         _loc2_.screen.gameObj.var_129.playSound("minigame_kart_horn.wav",false,0.7);
      }
      
      override public function destroy() : void
      {
         var _loc1_:MiniGameKart = this;
         _loc1_.setupBackdrop(false);
         _loc1_.clearObjects();
         _loc1_.setupKarts(false);
         _loc1_.objects = null;
         _loc1_.karts = null;
         _loc1_.kart = null;
         _loc1_.clip.removeEventListener(MouseEvent.MOUSE_DOWN,_loc1_.clickScreen);
         _loc1_.container.removeChild(_loc1_.clip);
         _loc1_.clip = null;
      }
      
      public function updateAllKarts() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MiniGameKart = this;
         if(!_loc2_.isIntro)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_.karts.length)
            {
               _loc2_.karts[_loc1_].setNextCoordinates();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < _loc2_.karts.length)
            {
               _loc2_.karts[_loc1_].updateCoordsForCollisions();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < _loc2_.karts.length)
            {
               _loc2_.karts[_loc1_].updateCoordsForCollisions(true);
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < _loc2_.karts.length)
            {
               _loc2_.karts[_loc1_].updateKart();
               _loc1_++;
            }
         }
      }
      
      public function depthSort() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MiniGameKart = this;
         var _loc3_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < _loc2_.karts.length)
         {
            _loc3_.push(_loc2_.karts[_loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.objects.length)
         {
            if(_loc2_.objects[_loc1_].isFlat == false && _loc2_.objects[_loc1_].clip.x > -50 && _loc2_.objects[_loc1_].clip.x < 700)
            {
               _loc3_.push(_loc2_.objects[_loc1_]);
            }
            _loc1_++;
         }
         _loc3_.sort(this.sortFunction);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_.clip.kartholder.setChildIndex(_loc3_[_loc1_].clip,_loc1_);
            _loc1_++;
         }
         _loc3_ = null;
      }
      
      public function setupKarts(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:GoKart = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:MiniGameKart = this;
         var _loc8_:Number = _loc7_.whichDifficulty - 1;
         var _loc9_:Array = [225,369,261,333];
         var _loc10_:Array = _loc7_.allCustomers.concat();
         if(param1)
         {
            _loc7_.karts = new Vector.<GoKart>();
            _loc2_ = 0;
            while(_loc2_ < _loc7_.kartData[_loc8_].length)
            {
               _loc4_ = String((_loc3_ = _loc7_.kartData[_loc8_][_loc2_]).customer);
               if(_loc7_.canRandomizeCustomers)
               {
                  class_7.method_1("(Random Customer)");
                  _loc6_ = Math.floor(Math.random() * _loc10_.length);
                  _loc4_ = String(_loc10_[_loc6_]);
                  _loc10_.splice(_loc6_,1);
               }
               _loc5_ = new GoKart(_loc7_,_loc7_.clip.kartholder,0,_loc9_[_loc2_],_loc4_,_loc3_.startingSpeed,_loc3_.accel,_loc3_.maxSpeed,false,_loc3_.avoid,_loc3_.collect);
               _loc7_.karts.push(_loc5_);
               _loc2_++;
            }
            _loc7_.kart = new GoKart(_loc7_,_loc7_.clip.kartholder,0,297,"player",_loc7_.startingSpeed,_loc7_.kartAccel,_loc7_.maxSpeed,true);
            _loc7_.karts.push(_loc7_.kart);
         }
         else
         {
            if(Boolean(_loc7_.karts) && _loc7_.karts.length > 0)
            {
               _loc2_ = int(_loc7_.karts.length - 1);
               while(_loc2_ >= 0)
               {
                  if(_loc7_.karts[_loc2_] != null)
                  {
                     _loc7_.karts[_loc2_].destroy();
                     _loc7_.karts[_loc2_] = null;
                  }
                  _loc7_.karts.splice(_loc2_,1);
                  _loc2_--;
               }
            }
            _loc7_.karts = null;
            _loc7_.kart = null;
         }
      }
      
      public function sortFunction(param1:Object, param2:Object) : Number
      {
         if(param1.y < param2.y)
         {
            return -1;
         }
         if(param1.y > param2.y)
         {
            return 1;
         }
         return 0;
      }
      
      public function showBanner(param1:Number = -1) : void
      {
         var _loc2_:MiniGameKart = this;
         if(param1 == -1)
         {
            _loc2_.clip.banner.gotoAndStop(1);
         }
         else
         {
            _loc2_.clip.banner.gotoAndStop(param1 + 1);
         }
         _loc2_.bannerTimer = 0;
         _loc2_.showingBanner = true;
      }
      
      public function checkSuccess() : void
      {
         var _loc1_:MiniGameKart = this;
         if(_loc1_.finishRank == 1)
         {
            _loc1_.decidePrize();
            class_7.method_1("Play Happy");
            _loc1_.screen.gameObj.var_129.playMusicClip("customer_happy.wav");
         }
         else
         {
            _loc1_.skuToWin = "tips";
            _loc1_.amountToWin = 10 * _loc1_.coinsCollected;
            if(_loc1_.amountToWin == 0)
            {
               _loc1_.amountToWin = 10;
            }
            if(_loc1_.finishRank == 2)
            {
               _loc1_.amountToWin *= 2;
            }
            _loc1_.skuIsClothing = false;
            _loc1_.skuClothingMode = "";
            class_7.method_1("Play Decent");
            _loc1_.screen.gameObj.var_129.playMusicClip("customer_decent.wav");
         }
      }
   }
}

