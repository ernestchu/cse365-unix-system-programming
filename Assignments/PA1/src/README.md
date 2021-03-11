# Assignment 1
### File Structure
```sh
.
├── assignment1.sh
└── ingredients
    ├── descriptions
    ├── directories
    ├── objects
    └── symlinks
```
### Requirement

* zsh installed
* 4 ingredients listed above
* Unix-like system

<details>
<summary>Install zsh</summary>

##### macOS
You should get zsh along with the recent macOS updates. If not
```sh
brew install zsh
```
##### Ubuntu
```sh
sudo apt-get install zsh
```
##### Debian
```sh
sudo apt install zsh
```
##### Fedora
```sh
sudo dnf install zsh
```
</details>

### Usage
#### Run
```sh
chmod u+x assignment1.sh
./assignment1.sh run
```
A `dunnet` directory will be created. Inside `dunnet`, there's `rooms` which we're required to created in this assignment.

A symbolic link `rooms` will also be created at your home directory, so I don't mess up your home like Steve does.

#### Clean
```sh
./assignment1.sh clean
```

#### Evaluate
You can evaluate the contents of `rooms` with the help of Steve's test program. Assume you placed your PA1 directory at the home directory (if not, you still have to make a symbolic link at there since Steve hard-coded the test program).

```sh
./assignment1.sh run
cd dunnet
~/PA1/findYourOutput.exe
cd ~/PA1
diff yourOutput expectedOutput 
```
There shouldn't be any output after `diff`.

### Description
#### Map
I modified the map from [Dunnet Guide](https://gist.github.com/kiedtl/06f728a414a7804826c378b214bf7726) to help you verifying your `buttonRoom` structure. The directions is in the alphabetical order to cope with the `tree` command.

`*` refers to the etrance/exit. `.` refers to the disallowed directions.

|                          | root dir = buttonRoom | d | e | n | ne | nw  | s  | se | sw | u | w  | You Move |
|--------------------------|-----------------------|---|---|---|----|-----|----|----|----|---|----|----------|
| 0 Weight room            |                       | 1 | . | . | .  | .   | .  | .  | .  | . | \* | Down     |
| 1 Maze button room       | /                     | 1 | 1 | . | 1  | (2) | .  | 1  | 1  | 0 | 1  | NW       |
| 2 little twisty          | /nw                   | 2 | 2 | 2 | 2  | 2   | 2  | .  | 2  | 3 | 2  | Up       |
| 3 thirsty little         | /nw/u                 | 2 | 2 | . | 3  | 3   | 2  | 4  | 3  | . | 3  | SE       |
| 4 twenty little          | /nw/u/se              | 5 | . | . | .  | .   | .  | .  | .  | . | 2  | Down     |
| 5 daze of twisty little  | /nw/u/se/d            | . | . | . | .  | 6   | .  | 4  | .  | . | .  | NW       |
| 6 twisty little cabbages | /nw/u/se/d/nw         | 2 | 2 | 2 | 0  | 7   | 2  | 2  | 2  | 2 | 2  | NE or NW |
| 7 Reception area         | /nw/u/se/d/nw/nw      | . | . | . | .  | .   | \* | 3  | .  | . | .  |          |

#### Script
For the details of the script, please look it up yourself.

For those who wondering where the ingredients came from:

* `directories` and `symlinks`

I hand-crafted them from the repeatedly modified instructions Steve gave. Of course, I build the file structure, then utilize `tree` to generate the files.

* `descriptions` and `objects`

Those are from the files that Steve gave but I hacked them in the script so I needn't copy and paste stuff...
```sh
==> ./buttonRoom/button <==
As you press the button, you notice a passageway open up, but
as you release it, the passageway closes.

==> ./buttonRoom/ladder <==
It is a normal ladder that is permanently attached to the hole.
```
The snippet from the `objects` is duplicated in the original file. This is a mistake made by Steve, so we have to delete it manually.
