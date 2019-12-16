
import strutils
import sequtils

const
  gcInputTest00 = "12345678"
  gcInputTest00Steps = 4

  gcInputTest01 = "80871224585914546619083218645595"
  gcInputTest01Steps = 100

  gcInputTest02 = "19617804207202209144916044189917"
  gcInputTest02Steps = 100

  gcInputTest03 = "69317163492948606335995924319873"
  gcInputTest03Steps = 100

  gcInputOk = "59713137269801099632654181286233935219811755500455380934770765569131734596763695509279561685788856471420060118738307712184666979727705799202164390635688439701763288535574113283975613430058332890215685102656193056939765590473237031584326028162831872694742473094498692690926378560215065112055277042957192884484736885085776095601258138827407479864966595805684283736114104361200511149403415264005242802552220930514486188661282691447267079869746222193563352374541269431531666903127492467446100184447658357579189070698707540721959527692466414290626633017164810627099243281653139996025661993610763947987942741831185002756364249992028050315704531567916821944"
  gcInputOkSteps = 100

  gcInput = gcInputOk
  gcInputSteps = gcInputOkSteps

  gcInputInt64 = gcInput.mapIt(($it).parseBiggestInt)
  gcInputI64 = block inputI64:
    var lResult: array[gcInputInt64.len, BiggestInt]
    for (i, v) in gcInputInt64.pairs:
      lResult[i] = v
    lResult
  gcInputI64Len = gcInputI64.len
  gcInputI64MaxIndex = gcInputI64Len.pred

  gcPattern = [0i64, 1, 0, -1]

proc partOne =
  var lResult: array[gcInputI64Len, BiggestInt] = gcInputI64

  for step in 1..gcInputSteps:
    var lInput = lResult
    for i in 0..gcInputI64MaxIndex:
      let len = (i+1)
      var lSum = 0i64
      for (j, v) in lInput.pairs:
        let lBPI = ((j + 1) div len) mod gcPattern.len
        lSum += (gcPattern[lBPI] * v)
      lResult[i] = parseBiggestInt($(($lSum)[^1]))

  echo "partOne ", lResult[0..7]


proc partTwo =
  const
    lTimes = 10000
  var lResult = newSeqOfCap[array[gcInputI64Len, BiggestInt]](lTimes)
  lResult.setLen(lTimes)
  for i in 0..lResult.len.pred:
    lResult[i] = gcInputI64
  var lInput = newSeqOfCap[array[gcInputI64Len, BiggestInt]](lTimes)
  lInput.setLen(lTimes)
  for step in 1..gcInputSteps:
    echo step
    for i in 0..lResult.len.pred:
      lInput[i] = lResult[i]
    for ii in 0..lTimes.pred:
      echo "-> ", ii
      for i in 0..gcInputI64MaxIndex:
        let len = (((ii * gcInputI64Len) + i) + 1)
        var lSum = 0i64
        for jj in 0..lTimes.pred:
          for (j, v) in lInput[jj].pairs:
            let lBPI = ((((jj * gcInputI64Len)+j) +
                1) div len) mod gcPattern.len
            lSum += (gcPattern[lBPI] * v)
        lResult[ii][i] = parseBiggestInt($(($lSum)[^1]))
  let lOffset = lResult[0][0..6].foldl($a & $b, "").parseBiggestInt
  var lMessage = ""
  for i in lOffset..lOffset+7:
    lMessage &= $lResult[i div gcInputI64Len][i mod gcInputI64Len]


  echo "partTwo ", lMessage


# partOne() # 10189359
partTwo() #XXXX
