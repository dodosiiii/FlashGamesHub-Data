package cheeseGame.data
{
   public class ClothingItem
   {
      
      public static const GENDER_MALE:String = "male";
      
      public static const GENDER_FEMALE:String = "female";
      
      public static const GENDER_ALL:String = "all";
      
      public static const GENDER_SWAP:String = "swap";
      
      public static const TYPE_SHIRT:String = "shirt";
      
      public static const TYPE_PANTS:String = "pants";
      
      public static const TYPE_JACKET:String = "jacket";
      
      public static const TYPE_SHOES:String = "shoes";
      
      public static const TYPE_HAIR:String = "hair";
      
      public static const TYPE_FACIALHAIR:String = "facialhair";
      
      public static const TYPE_BANGS:String = "bangs";
      
      public static const TYPE_ACC_BODY:String = "acca";
      
      public static const TYPE_ACC_BELT:String = "accb";
      
      public static const TYPE_ACC_ARMS:String = "accc";
      
      public static const TYPE_ACC_FACE:String = "accd";
      
      public static const TYPE_HAT:String = "hat";
      
      public static const OPTIONS_HIDE_SHIRTNECK:uint = 1;
      
      public static const OPTIONS_HIDE_SHIRTBICEP:uint = 2;
      
      public static const OPTIONS_HIDE_JACKETNECK:uint = 4;
      
      public static const OPTIONS_HAS_BICEP:uint = 8;
      
      public static const OPTIONS_HAS_FOREARM:uint = 16;
      
      public static const OPTIONS_HAS_NECK:uint = 32;
      
      public static const OPTIONS_HAS_FRONTBODY:uint = 64;
      
      public static const OPTIONS_HAS_BACKBODY:uint = 128;
      
      public static const OPTIONS_HAS_BACK_HAIR:uint = 256;
      
      public static const OPTIONS_HAS_MOUTH_FACIALHAIR:uint = 512;
      
      public static const OPTIONS_HAS_BASE_FACIALHAIR:uint = 1024;
      
      public static const OPTIONS_TRACKEYES:uint = 2048;
      
      public static const OPTIONS_ONLYONEARM:uint = 4096;
      
      public static const OPTIONS_HIDE_SHIRTFOREARM:uint = 8192;
      
      public static const OPTIONS_IS_NECKLACE:uint = 16384;
      
      public static const OPTIONS_BEHINDCOLLAR:uint = 32768;
      
      public static const OPTIONS_ACCSTAYSBACK:uint = 65536;
      
      public static const OPTIONS_HAT_CAP:uint = 131072;
      
      public static const OPTIONS_HAT_HELMET:uint = 262144;
      
      public static const OPTIONS_HAT_SOMBRERO:uint = 524288;
      
      public static const OPTIONS_HAT_HAIRCLIP:uint = 1048576;
      
      public static const OPTIONS_SUPPORTS_BANGS:uint = 2097152;
      
      public static const OPTIONS_HAT_FULLMASK:uint = 4194304;
      
      public static const OPTIONS_HAS_CUFF:uint = 8388608;
      
      public static const OPTIONS_ACC_BEHINDJACKET:uint = 2097152;
      
      public static const OPTIONS_ACC_BEHINDJACKETNECK:uint = 524288;
      
      public static const OPTIONS_HAS_HAND:uint = 16777216;
      
      public static const OPTIONS_HAS_FLAREDSLEEVES:uint = 33554432;
      
      public static const OPTIONS_HAS_ALTERNATEGLOVE:uint = 131072;
      
      public static const OPTIONS_ACCBEHINDBELT:uint = 256;
      
      public static const OPTIONS_HAS_HOCKEYSLEEVES:uint = 512;
      
      public static const SHIRT_SHORT:uint = ClothingItem.OPTIONS_HAS_BICEP;
      
      public static const SHIRT_LONG:uint = ClothingItem.OPTIONS_HAS_BICEP | ClothingItem.OPTIONS_HAS_FOREARM;
      
      public static const SHIRT_SLEEVELESS:uint = 0;
      
      public static const SHIRT_SHORT_COLLAR:uint = ClothingItem.OPTIONS_HAS_BICEP | ClothingItem.OPTIONS_HAS_NECK;
      
      public static const SHIRT_LONG_COLLAR:uint = ClothingItem.OPTIONS_HAS_BICEP | ClothingItem.OPTIONS_HAS_FOREARM | ClothingItem.OPTIONS_HAS_NECK;
      
      public static const FACIALHAIR_FULL:uint = ClothingItem.OPTIONS_HAS_BASE_FACIALHAIR | ClothingItem.OPTIONS_HAS_MOUTH_FACIALHAIR;
      
      public static const FACIALHAIR_JUSTMOUTH:uint = ClothingItem.OPTIONS_HAS_MOUTH_FACIALHAIR;
      
      public static const FACIALHAIR_JUSTBASE:uint = ClothingItem.OPTIONS_HAS_BASE_FACIALHAIR;
      
      public static const BODYACC_FULL:uint = ClothingItem.OPTIONS_HAS_BACKBODY | ClothingItem.OPTIONS_HAS_FRONTBODY;
      
      public static const BODYACC_FULL_NECK:uint = ClothingItem.OPTIONS_HAS_BACKBODY | ClothingItem.OPTIONS_HAS_FRONTBODY | ClothingItem.OPTIONS_HAS_NECK;
      
      public static const BODYACC_FRONT:uint = ClothingItem.OPTIONS_HAS_FRONTBODY;
      
      public static const BODYACC_BACK:uint = ClothingItem.OPTIONS_HAS_BACKBODY;
      
      public static const JACKET_COLLAR_COVERARMS:uint = ClothingItem.OPTIONS_HAS_NECK | ClothingItem.OPTIONS_HAS_BICEP | ClothingItem.OPTIONS_HAS_FOREARM | ClothingItem.OPTIONS_HIDE_SHIRTBICEP | ClothingItem.OPTIONS_HIDE_SHIRTFOREARM;
      
      public static const JACKET_COLLAR_COVERARMSANDNECK:uint = ClothingItem.OPTIONS_HAS_NECK | ClothingItem.OPTIONS_HAS_BICEP | ClothingItem.OPTIONS_HAS_FOREARM | ClothingItem.OPTIONS_HIDE_SHIRTBICEP | ClothingItem.OPTIONS_HIDE_SHIRTFOREARM | ClothingItem.OPTIONS_HIDE_SHIRTNECK;
      
      public static const JACKET_COVERARMS:uint = ClothingItem.OPTIONS_HAS_BICEP | ClothingItem.OPTIONS_HAS_FOREARM | ClothingItem.OPTIONS_HIDE_SHIRTBICEP | ClothingItem.OPTIONS_HIDE_SHIRTFOREARM;
      
      public static const JACKET_COLLAR_SHORTSLEEVE:uint = ClothingItem.OPTIONS_HAS_NECK | ClothingItem.OPTIONS_HAS_BICEP | ClothingItem.OPTIONS_HIDE_SHIRTBICEP;
      
      public static const JACKET_COLLAR_SLEEVELESS:uint = ClothingItem.OPTIONS_HAS_NECK;
      
      public static const GLOVE_FOREARM:uint = ClothingItem.OPTIONS_HAS_HAND | ClothingItem.OPTIONS_HAS_FOREARM;
      
      public static const GLOVE_SHORT:uint = ClothingItem.OPTIONS_HAS_HAND;
      
      public static const GLOVE_LONG:uint = ClothingItem.OPTIONS_HAS_HAND | ClothingItem.OPTIONS_HAS_FOREARM | ClothingItem.OPTIONS_HAS_BICEP;
      
      public static const TINT_RED:uint = 16727614;
      
      public static const TINT_ORANGE:uint = 16737536;
      
      public static const TINT_YELLOW:uint = 16776960;
      
      public static const TINT_GREEN:uint = 1162257;
      
      public static const TINT_BLUE:uint = 26316;
      
      public static const TINT_PURPLE:uint = 7749269;
      
      public static const TINT_PINK:uint = 16744396;
      
      public static const TINT_WHITE:uint = 16777215;
      
      public static const TINT_BLACK:uint = 2236962;
      
      public static const TINT_GRAY:uint = 13421772;
      
      public static const TINT_DARKGRAY:uint = 8355711;
      
      public static const TINT_ARMYGREEN:uint = 7379003;
      
      public static const TINT_KHAKI:uint = 12492402;
      
      public static const TINT_BRASS:uint = 13018488;
      
      public static const TINT_BROWN:uint = 10506286;
      
      public static const TINT_GOLD:uint = 16763904;
      
      public static const TINT_TEAL:uint = 442079;
      
      public static const TINT_LIGHTBLUE:uint = 6069180;
      
      public static const TINT_SEAFOAM:uint = 3669971;
      
      public static const TINT_LIGHTGREEN:uint = 12383570;
      
      public static const TINT_PALEBLUE:uint = 13428223;
      
      public static const TINT_MAROON:uint = 13516648;
      
      public static const TINT_MOCHA:uint = 6637878;
      
      public static const TINT_LIGHTBROWN:uint = 10382670;
      
      public static const TINT_DARKBROWN:uint = 7619113;
      
      public static const TINT_BURNTUMBER:uint = 11684864;
      
      public static const TINT_DARKRED:uint = 12255232;
      
      public static const TINT_DENIM:uint = 2709362;
      
      public static const TINT_STONEWASH:uint = 5595780;
      
      public static const TINT_NAVYBLUE:uint = 1321814;
      
      public static const TINT_DEEPBLACK:uint = 0;
      
      public static const TINT_LAVENDER:uint = 14469112;
      
      public static const TINT_STRAW:uint = 14800816;
      
      public static const TINT_CREAM:uint = 15724007;
      
      public static const TINT_DARKLAVENDER:uint = 11112384;
      
      public static const TINT_LIGHTORANGE:uint = 16688164;
      
      public static const TINT_LIGHTTEAL:uint = 13041663;
      
      public static const TINT_LIGHTPINK:uint = 16764159;
      
      public static const TINT_DUSTYBLUE:uint = 3234439;
      
      public static const TINT_BEIGE:uint = 13221816;
      
      public static const TINT_BRIGHTGOLD:uint = 16763904;
      
      public static const TINT_LIMEGREEN:uint = 12109338;
      
      public static const TINT_BRONZE:uint = 13672772;
      
      public var gender:String;
      
      public var type:String;
      
      public var tag:String;
      
      public var title:String;
      
      public var description:String;
      
      public var options:uint;
      
      public var price:Number = 0;
      
      public var inStore:Boolean = true;
      
      public var addToDefaultInventory:Boolean = false;
      
      public var holidayBonus:Number = 0;
      
      public var tintSKU:String = null;
      
      public var tintColor1:Number = -1;
      
      public var tintColor2:Number = -1;
      
      public var tintColor3:Number = -1;
      
      public var tintDecal:String = null;
      
      public var tintDecalColor:Number = -1;
      
      public var tintGroup:String = null;
      
      public var tintPreviewColor:Number = -1;
      
      public function ClothingItem(param1:String, param2:String, param3:String, param4:String, param5:Number = 0, param6:String = "all", param7:uint = 0, param8:Boolean = true, param9:Boolean = false, param10:Number = 0, param11:String = null, param12:Number = -1, param13:String = null, param14:Number = -1, param15:Number = -1, param16:Number = -1, param17:String = null, param18:Number = -1)
      {
         super();
         this.tag = param1;
         this.title = param2;
         this.description = param3;
         this.type = param4;
         this.price = param5;
         this.gender = param6;
         this.options = param7;
         this.inStore = param8;
         this.addToDefaultInventory = param9;
         this.holidayBonus = param10;
         this.tintSKU = param13;
         this.tintColor1 = param14;
         this.tintColor2 = param15;
         this.tintColor3 = param16;
         this.tintGroup = param11;
         this.tintPreviewColor = param12;
         this.tintDecal = param17;
         this.tintDecalColor = param18;
      }
      
      public function hasOption(param1:uint) : Boolean
      {
         return (this.options & param1) == param1;
      }
      
      public function isTinting() : Boolean
      {
         if(this.tintSKU == null)
         {
            return false;
         }
         return true;
      }
   }
}

