lib.jumpMenu = COA
lib.jumpMenu {
  10 = HMENU
  10 {
    entryLevel = 0
    wrap = <form id="level1" action="index.php" method="get" enctype="multipart/form-data">|</form>
    1 = TMENU
    1 {
      wrap = <select name="id" onchange="submit();">|</select>
      NO = 1
      NO {
        doNotLinkIt = 1
        stdWrap.cObject = COA
        stdWrap.cObject {
          10 = TEXT
          10.data = leveltitle:0
          10.dataWrap = <option value="{leveluid:0}">--|--</option>
          10.if.value = 2
          10.if.isLessThan.data = register:count_HMENU_MENUOBJ
          20 = TEXT
          20.value = <option value="
          30 = TEXT
          30.dataWrap = {field:uid}">
          40 = TEXT
          40.field = nav_title // title
          50 = TEXT
          50.value = </option>
        }
      }
      ACT < .NO
      ACT {
        stdWrap.cObject {
          30.dataWrap = {field:uid}" selected="selected">
        }
      }
    }
  }
  20 < .10
  20 {
    entryLevel = 1
    wrap = <form id="level2" action="index.php" method="get" enctype="multipart/form-data">|</form>
    1 {
      NO {
        stdWrap.cObject {
          10.data = leveltitle:1
          10.dataWrap = <option value="{leveluid:1}">--|--</option>
        }
      }
      ACT {
        stdWrap.cObject {
          10.data = leveltitle:1
          10.dataWrap = <option value="{leveluid:1}">--|--</option>
        }
      }
    }
  }
  30 < .10
  30 {
    entryLevel = 2
    wrap = <form id="level3" action="index.php" method="get" enctype="multipart/form-data">|</form>
    1 {
      NO {
        stdWrap.cObject {
          10.data = leveltitle:2
          10.dataWrap = <option value="{leveluid:2}">--|--</option>
        }
      }
      ACT {
        stdWrap.cObject {
          10.data = leveltitle:2
          10.dataWrap = <option value="{leveluid:2}">--|--</option>
        }
      }
    }
  }
  40 < .10
  40 {
    entryLevel = 3
    wrap = <form id="level4" action="index.php" method="get" enctype="multipart/form-data">|</form>
    1 {
      NO {
        stdWrap.cObject {
          10.data = leveltitle:3
          10.dataWrap = <option value="{leveluid:3}">--|---</option>
        }
      }
      ACT {
        stdWrap.cObject {
          10.data = leveltitle:3
          10.dataWrap = <option value="{leveluid:3}">--|--</option>
        }
      }
    }
  }
  wrap = <div id="jumpMenu">|</div>
}